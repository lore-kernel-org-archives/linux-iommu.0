Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C937EBB
	for <iommu@lists.linux.dev>; Thu, 30 Jun 2022 09:59:16 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id k7so1988206wrc.12
        for <iommu@lists.linux.dev>; Thu, 30 Jun 2022 02:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1HMqmjT/Hl6eEoSqluU6kzXOVYJu96vbsB8yRH3pJM0=;
        b=b/EZPJfCnVquS1NkGq9KsRSBoCZWR7XOtN+NA+DS6Z90ExfXr1goihQkGLPJKgOpGD
         E41Z7SVhSHeZcyHhReeC5glNz/sMI+cacocAN+FidqgorPd7cmOUipobq8s3bUis9MnM
         qN2to17GprO8783SMo6neHc53795eruPe6diqQbC/ekLR3M7MhW1cfyEJ61Rna83MVqL
         6nlD9F4GRvs/uFvHk2Aa7rCsMyacwzeNcrwQP2n8ntFdc8CqWzQNfHv8NM6Zm86Kj1zY
         ZlVEd7Aoikx9hXwEINGCgvU2Uf2TgLEm2ZqLLW9EV0ImXR0vBTs6xYbWLT8QCxzhNWPs
         qFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1HMqmjT/Hl6eEoSqluU6kzXOVYJu96vbsB8yRH3pJM0=;
        b=qfiLJA7Ba6TwETnyvxJoYlxObi48tacejK4c8jXAljELV5slrK7rpFei1wSzMCJYVi
         xh9h3BKi6NAZBusjySiNzzKTpdGeXuvVdDqhbernFUv6ijzDr4USLGeLl7wmy0/8GQzf
         +g/D4RL7pFU4RCkYD/VHCviYvxtmklrbza8EtYVbws2Kn5hOpA73lJEmDbXB/GXNIhtt
         4VOOjE052OF94DvLIEx5A7BIXGF7Q0Jowk26w/YVw1LB/J3kBpTSk8VjEwtPAMKorFn3
         Fqtpufz3Ntny5nOVSOMy48VEZWD2GSbnBd14YEDA8IxuI6qKU17DJHepE5ztz5A2SeBl
         P8cQ==
X-Gm-Message-State: AJIora9TnmgZznoJ2gDvG2wxx4dR+WbQZm7IxOTPIXd+VyyfZ/h21FVz
	rdYU/h5ltcecUUB/EiV/i4p36w==
X-Google-Smtp-Source: AGRyM1vfHfveCYpKUn92Ua/tYhN63FUv0q/bxKLp7QoY98RJ551Y0CyHmJgnGxT6j3AABaTfE3i9OA==
X-Received: by 2002:adf:d1ca:0:b0:21b:a81c:47f3 with SMTP id b10-20020adfd1ca000000b0021ba81c47f3mr7539642wrd.22.1656583155303;
        Thu, 30 Jun 2022 02:59:15 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05600c3d9200b0039c4506bd25sm2572630wmb.14.2022.06.30.02.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 02:59:14 -0700 (PDT)
Date: Thu, 30 Jun 2022 10:58:50 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, jroedel@suse.de, linux-acpi@vger.kernel.org,
	iommu@lists.linux-foundation.org, rafael@kernel.org,
	lenb@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, jinl@redhat.com
Subject: Re: [PATCH v2] ACPI: VIOT: Fix ACS setup
Message-ID: <Yr1z2gC0+8zbzpFf@myrica>
References: <20220630094059.1204283-1-eric.auger@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630094059.1204283-1-eric.auger@redhat.com>
Message-ID: <20220630095850.z8dj9GXKBTtRTtVmic44SMpJpbSYJC7o_cA8PjmOO60@z>

On Thu, Jun 30, 2022 at 11:40:59AM +0200, Eric Auger wrote:
> Currently acpi_viot_init() gets called after the pci
> device has been scanned and pci_enable_acs() has been called.
> So pci_request_acs() fails to be taken into account leading
> to wrong single iommu group topologies when dealing with
> multi-function root ports for instance.
> 
> We cannot simply move the acpi_viot_init() earlier, similarly
> as the IORT init because the VIOT parsing relies on the pci
> scan. However we can detect VIOT is present earlier and in
> such a case, request ACS. Introduce a new acpi_viot_early_init()
> routine that allows to call pci_request_acs() before the scan.
> 
> While at it, guard the call to pci_request_acs() with #ifdef
> CONFIG_PCI.
> 
> Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Jin Liu <jinl@redhat.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

