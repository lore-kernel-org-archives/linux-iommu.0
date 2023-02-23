Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A228ED
	for <iommu@lists.linux.dev>; Thu, 23 Feb 2023 15:45:21 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id 6so10620758wrb.11
        for <iommu@lists.linux.dev>; Thu, 23 Feb 2023 07:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WUtJHy11n8Y/rq9v+tVThHOQuEU8nOltQBq6+LKXmIk=;
        b=V1VQBLeFVTmxch5HEcztI6KEJGkyu1+nRlw56ftIe1im+aJWKgbqYdAczH9MK4nC2m
         VRJKqGb1sNoAUU8J+HpwV/DWY162iNiiLL77tJDM36JkfzuRBNGbVcIGcu41RN/JpyF7
         b/qNt2HrhUeVDeuRZZkssDz7xlFAjQ197Ip9bQIKM/O+jnUetREpkeJlbtBRPt2Cz1LJ
         lxb8nUSYSBGTb20p4Q0SjRsuITeloeoW3tHqnuL/AnB1guCJZ5shwQQeWDI5VQKyIHlF
         GYaGjPJji34I4D5O5q8mWakY83vQYhaAFtWTJ8yJFnWWBZ4v4ULq0OoA8ipwMjzpn+28
         Gokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUtJHy11n8Y/rq9v+tVThHOQuEU8nOltQBq6+LKXmIk=;
        b=b43uwqIxqUpBJ3w5AFwNZuqLes8V+5MlraKhWpjY/9Tuivkec7fi/2x2Y0LTGAaus2
         w4YOm7pLiiITFJFFJ7lTke5w3DX9B5rXsyGobU/06/MVpdpj4KzUKdSQKruhA7U9g2Hm
         r28vAM8K5mII7OHxmLLHOj5k1te5prBh7ck4k49C4nE5mfF7j8As96bNnaykwYyT3Mat
         FcW4dFN8bNq+TOdUJCJi3gzqiT51e9xyzq2buG9kfsR1oJzI/2R/mR6qkQ2IITNLUpuM
         0gZpbfx70TU1nJSdb5r2ZIPF77SYeQGP7qFS0K9BepHeSKdNrpMaB6eL6y/NIyvQauxq
         iibA==
X-Gm-Message-State: AO0yUKWtStxso85Q/0CIPWyYb+8O639sf1saB/hjuDUh3rTRiD+6eGgf
	IklWB9PkJml1m2M8m5+gBZ/OUw==
X-Google-Smtp-Source: AK7set+vIXFCFewCWF4qBdv5jm6siVTdfVVno5o1udTzlHH2yBZRGnoaUdEWRd1WBIcsio02GMoW9Q==
X-Received: by 2002:a5d:4610:0:b0:2c5:561e:808e with SMTP id t16-20020a5d4610000000b002c5561e808emr13069275wrq.12.1677167119643;
        Thu, 23 Feb 2023 07:45:19 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id t6-20020a5d4606000000b002c55306f6edsm13876488wrq.54.2023.02.23.07.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 07:45:19 -0800 (PST)
Date: Thu, 23 Feb 2023 15:45:20 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, darren@os.amperecomputing.com,
	scott@os.amperecomputing.com, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH] PCI/ATS:  Allow to enable ATS on VFs even if it is not
 enabled on PF
Message-ID: <Y/eKEMo1moXt3pPP@myrica>
References: <Y+4PmJb2rBGMhS1y@myrica>
 <20230221154624.GA3701506@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221154624.GA3701506@bhelgaas>

On Tue, Feb 21, 2023 at 09:46:24AM -0600, Bjorn Helgaas wrote:
> It's weird to me that the SMMU is between PCI and memory, but the
> driver seems to insert itself in the middle after PCI enumeration.
> And maybe even after some PCI device driver binding?

No this shouldn't happen, because device drivers expect DMA to be
operational in their probe() function, so at that point the IOMMU must be
configured. The core and IOMMU subsystems enforce probe dependency between
the SMMU and the PCI device, using links described by ACPI or device tree.

Thanks,
Jean
