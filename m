Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B3764B
	for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 06:49:00 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4036bd4fff1so234271cf.0
        for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 23:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689922139; x=1690526939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hQfAD+gRLI1T8q/mSuX9jGerjy3VlrCpnWiJnxkvDK4=;
        b=PBzSzI5mVQ/5a0fwR+VlN0WqFzdvb24sVzYk0n0+bTqCQzQa9csh0dy4gS5kXQHp67
         MKkKSATVkGuzPY8qn5m2u/mvcGKjB4Zb9JlMp5FnzaHu4U4cZWIzwxZE3KBC5rwVRw1h
         NFTU4/E23Ju1Ci29D+suAsxxBZ4CJjUwd8JeyIvkj2ygeqjLKbZItldXD4pimtOnoixo
         y/FQhaHi6M2Hx0EG8StuDOSL+U/do7x+li8NJL5T/gTt8cy4HrxEbuw1cgMQAQxB9Fmr
         Az8pr28i8zXNh3NpIkNyfTJyunXmH8cvN/hRRSE+b0NiDvK19xOaxRzqZQnC7gCIlE9m
         nAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689922139; x=1690526939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQfAD+gRLI1T8q/mSuX9jGerjy3VlrCpnWiJnxkvDK4=;
        b=altidQPyOfYXwDFhZXUDE950XD9bXI+WNUHM4IStqqCSYCqS2L6lJA+QJgJCAX/+AK
         ChaFR17yq0s391yEam4XvzeSutlwPFOXgHmwONnIet+hYk0OBZRU/vERLVn5YmYmcUQ3
         VSajsHHn5J0QtulXZ48rMQyeL5fJzmPX2xEP0r/K7lnyMBOFnbUXrxdAV5u5SN8vS2uG
         hlVaSbs8MWpXoW9nvM87JqcyFie0UOhUipKgND92k1RukE+mprsYlj6gFC11Nyedme/V
         BQDezRcTo9VZKv7A2CryVDGJIbVt10OKmu1IyrezzM0VmeWpG/C6jGQECCCaLeV100dq
         1wrw==
X-Gm-Message-State: ABy/qLYcOfJPa9VDymIGeayxgnLDqHOcCve9evYd3prkzs3d/jwvCreQ
	PRK8LMX/498P7TXNBXbkUDBJN+oh4u6mR3PW+EmjQg==
X-Google-Smtp-Source: APBJJlEld3XqjQTnMeJZ2GV04gPcS+P8zcQ/fL27WUjm6UoEiTkHArYFvXo8lTGeifb9JjvEN7kHAFibO6MUi3PDPZI=
X-Received: by 2002:ac8:5716:0:b0:3ef:302c:319e with SMTP id
 22-20020ac85716000000b003ef302c319emr186241qtw.8.1689922139427; Thu, 20 Jul
 2023 23:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-8-mshavit@google.com>
 <ZK9cyDaFkAKc1SvJ@Asurada-Nvidia>
In-Reply-To: <ZK9cyDaFkAKc1SvJ@Asurada-Nvidia>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 21 Jul 2023 14:48:23 +0800
Message-ID: <CAKHBV27FbpJHoPC5_8mCYHmhEbCaCE7st_-qzPv0uQYSH3RC9g@mail.gmail.com>
Subject: Re: [PATCH v4 07/13] iommu/arm-smmu-v3: Keep track of attached ssids
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, jgg@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> And since we have a group of subdomains that are simply indexed
> by ssids, perhaps we can add an xarray to store a subdomain ptr
> along with an ssid, replacing the list?

Hmmmm, I think the only place where we search through the list for a
specific SSID is during remove_dev_pasid. We mostly use the list to
iterate over  all the masters/ssids that this domain is attached to.
I'm not sure if moving to an xarray to optimize the remove_dev_pasid
call is worth it (at the cost of iterations which IIUC would become N
log(N))
