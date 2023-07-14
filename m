Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F36DF6A
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 09:31:19 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4036bd4fff1so279831cf.0
        for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689327078; x=1691919078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A15vHDj+qs7UNZzBMwI03zJC4sCAs4aUuXDdRIcnSVs=;
        b=23t02nWITv0Wxxhxy3MrlVo5UpZWpGqtNY99JyVpc4i0YrPyJFugH+a74Z+HQejnwi
         8y5tjlwL8dyocmDUsnu6466nguP409GuVO8AdgF5U7jhlWuUE/LVvDLiIC6WZthjJoJ/
         KHT814wJXQ7pO24EglIwQ3jjatH6YGtTFDqrzAGJQwnMNAxUhoQWVlJ8sKLvkc2b3ymj
         ESNz47qPcei7L/zYjdgb9JXnKVuVqz5Yr2VksPxKXLPtqKXf2uBLI3Wu0EMNF5tc0943
         Kstyzn6haWUeikwLIsqP5/THMoQ20VejsqUy5ZV/VF2DjU2NSB7nfTZtVA26Iq+s4Kd9
         2umQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689327078; x=1691919078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A15vHDj+qs7UNZzBMwI03zJC4sCAs4aUuXDdRIcnSVs=;
        b=VO/fCvV39x5puyibFcTDIkH1ejeYfWcNuWbNSjDP0p/EefZ65WTJNKPjr096oXZbIf
         SrBhjwjFPZBnvHeYbrqDNPuzbovYwPXqInWqYOBPVd7+zi8fz21T/ufpJ1drWCfNs6Qj
         Pg06Iy/mHyQaDwyU58I1ULSubLRbbVCDoP9POs84kjPDzs36DG2pQcbr30ZAcBkpSjUK
         t9ZooXN5qaISyNR381aUIchlYWodns45ExkGxgqysxr4ULf0M6jkKWvps+Mt589oDzax
         iPqz3Esk9RJJ5WsjGJbGQ0McGvmxx43ZRPFV6K1jQrnSoJRIj0OygOpmRQ0H/oNOLOBw
         3kDw==
X-Gm-Message-State: ABy/qLaRcFq/tfR6I39WuqPkMuCpj5H2xb39e7KbZU/7ZPSMFT+vqIus
	KW/HYK2zm0AuPLvmFVzqYMCJn+KqxJfwbv43i6RHIg==
X-Google-Smtp-Source: APBJJlGtQLNZ4CEjh45JYoT5xoNYLOuQWA5N5tdWmCZZHh+lh09PpSw9EjeWvnMLktNTEQAQXk16GheQDjXDImQhu8o=
X-Received: by 2002:a05:622a:394:b0:3fa:45ab:22a5 with SMTP id
 j20-20020a05622a039400b003fa45ab22a5mr792166qtx.27.1689327078299; Fri, 14 Jul
 2023 02:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-8-mshavit@google.com>
 <ZK+BZhwbo8JLMPI2@Asurada-Nvidia>
In-Reply-To: <ZK+BZhwbo8JLMPI2@Asurada-Nvidia>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 14 Jul 2023 17:30:42 +0800
Message-ID: <CAKHBV27idVJ-8YgpekezaQP2n+Oz6OpKnDmYiu_cSOFh6z1S+Q@mail.gmail.com>
Subject: Re: [PATCH v4 07/13] iommu/arm-smmu-v3: Keep track of attached ssids
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, jgg@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> And I don't quite get this part. Prior to this change, it issues
> one ATC_INV command covering all ATC entries per comments inside
> arm_smmu_atc_inv_to_cmd(). But now we replace that single command
> with all attached subdomains in the list? Any reason for such a
> change here?

Because we don't necessarily want to invalidate all PASID-domains
attached to a master. If arm_smmu_atc_inv_domain() is called on a
domain that is only attached with Pasid, we can restrict the
invalidations to those specific PASID by looping over them. But yeah,
you're right that we could potentially optimize this?
* Skip the per-pasid invalidations if the domain is also attached to
this master without PASID as we have to invalidate all its pasids in
that case anyways. It's hard to imagine clients attaching a domain
both with pasid and without pasid to the same device but could be
possible.
* Always invalidate all pasids by issuing atc invalidations on SSID 0.
This sounds like the wrong trade-off??
