Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356372EF660
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 03:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770347246; cv=none; b=S9MnhFfX9dHw/8Q0JXI3T7pLl6bswL6jw295K6da6aFkBraQRbkarABMcHH3oKyrDD0CqJKaurqI2aDj8WgUn8vqorimNlng1ljUI3XZhiKFUevdnayJWjYs6096BGwlyHWKAtsKU632XLF7YtaDFqNWHTvdNL98kJmAUB5zFi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770347246; c=relaxed/simple;
	bh=p4tkB2ZlK2UsmWYUfM+N0mNovdhusjrLeAlSeh8H1k8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Usx0vi0LNQLQ0XtIE4Y0Jafc2vW6yLhpT+HjrlMb8fPwpQDuSmY/3FPS0YvpIu5oVyXo63xfg1xDPa9/PugI65rf3YwB6LX99v3I5LGqWDHuFX8+ejNl9OA88ODjJyelnZPW0TCLrdZ7dNC7Ggg/9vCXnCayQAmpdC28j7CQ134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIgcttSy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIgcttSy"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a7a23f5915so11860575ad.2
        for <iommu@lists.linux.dev>; Thu, 05 Feb 2026 19:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770347245; x=1770952045; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTLlWgup/boAOL11HN9YevGJP11uRzIBi2lM6iUJUmI=;
        b=WIgcttSy/LG/2RQu56hgrmWict7y5X8BctzXdjyK2I0ma4PUL8eLiWObSCsStSabWz
         UYzpWzNGYD13IQtdHqn0IGQ5rrBKIE8gufGcKn2MNgkxLFL4bXTLBje+k6jJOU85tqQn
         h84t/ldSH2FUMfPbYO1qQiutvA0Uxtf5j2x1PfCC4tTU7n8Xa+HOnmAiU7FJl14XBJQq
         s387jtRi5a9Ot/Oy162a5ychfaWbpH26rrQq0Y5D3t03/wwpdx4Po0RYq8/Vcb9VEPor
         bZ4fkVnvgCDIdht+lwLajqbq0B59XOLTc0KpNfCrNOrdepkIeZDk6veE1WiE8yFBcqYb
         AU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770347245; x=1770952045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vTLlWgup/boAOL11HN9YevGJP11uRzIBi2lM6iUJUmI=;
        b=X1IzZjoLYY9S+E85c+QLycNRuYG2f04QZLlztDd62cGNrlJnuFQkEOtFOQ2fFS8Ow3
         q09hzFxzFByXECpelok5CRuPlaYA+vXUxXVcQg646sY+OZWrti42auZtMP5/mn9pYNIK
         BF64/okI1UvWkfqErtlW/QqmgHg8gP/C+dxLVn7NxOEZXrbL+yvnMa4bsgGM0jULOu9s
         KMy3R1b0vTGtNEEqFoX2vhNRD7cF6bOAXnUZqnBWTzi3EnSpad8Wj876zVAwL7Wj5MnZ
         3gTObV9w7lYf/RiIVXT9tlYv+RpsOz7s+I050OodWL1rXK9jLAoZ+tdJ6RKj/oJ1aI7g
         jDeg==
X-Forwarded-Encrypted: i=1; AJvYcCWeISqerX5UUnZGpp8E4nLvAMKnAv45Q4vcQ8VQQZrc4AD9/XmEyvk59Pd51dTl+NcE/cdV0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxS2T8UHGCS31h4gpFUlwaN1OTHQKONW250RcEaWHmbslq6hgTG
	qWY3gVp77GhvQ1Ti1G0IbZuOd/laaGlkbl2cEiOsTH1fLeP4O/yc331o
X-Gm-Gg: AZuq6aIQbZ6sOqxSkDvQOkRmL8Kps3huMzr1wxpw7v0c5bOcLh+CyE6MqSufsnLoOEs
	GLHtB0BEa76JAeXbc+YzCveKOQlgc3WImctJY6CPssx1+nVjx6WG6We+KxPNqUahnOfzo/HADZD
	ByacgB80eIbXFaQS80ZYwex7q7hKGCMpCYvIp3Us9BLUf7D2rh7azbNzHRk8kGHndh1eVb+ntX7
	i/Qk8nWxbIdRMoDvl1CkdWlGg6PWA6i1TEtaPIykazYXoUIsZPCJlNmBgQ6JhxwVzTIMrCIfm2x
	2vWJqMU5K4ddpLCYSLbRLYyj32/ibr1uldrnKmIwd6Gj2+6V99jJNjL76BjqWtulPFIOUJ746Mj
	C3+QKgULCVvAxTDUmm4AQ1hTEh0/RSQ6GLlr7aVnhvb7KlmiW/Ud2nsmU5G3+a5w4yOXvUXEMn2
	zXvGrfwn6JwiuS/TmBO5eR9RPze8B6p38AC46DsciqmI4=
X-Received: by 2002:a17:902:db08:b0:2a7:d42f:7065 with SMTP id d9443c01a7336-2a9521689bbmr13706725ad.27.1770347245440;
        Thu, 05 Feb 2026 19:07:25 -0800 (PST)
Received: from localhost ([101.44.82.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521b9bebsm7512525ad.56.2026.02.05.19.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 19:07:25 -0800 (PST)
Date: Fri, 6 Feb 2026 11:06:57 +0800
From: DaiZhiyuan <jerry.zhiyuan.dai@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Zhiyuan Dai <daizhiyuan@phytium.com.cn>, will@kernel.org,
 joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Restrict MMU-700 errata 2268618 and
 2812531 to affected
Message-ID: <20260206110657.000043f7@gmail.com>
In-Reply-To: <3f22f7b8-449c-40d9-b4c8-fff3e520d563@arm.com>
References: <20260205093356.4328-1-daizhiyuan@phytium.com.cn>
	<3f22f7b8-449c-40d9-b4c8-fff3e520d563@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Feb 2026 13:05:24 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> On 05/02/2026 9:33 am, Zhiyuan Dai wrote:
> > According to SDEN-1786925, Arm errata 2268618 and 2812531 are
> > present in r0p0, r0p1, and r1p0, and fixed in r1p1.  
> 
> This is a bit fiddly, since these workarounds also overlap some other 
> errata that IIRC were *not* fixed in r1p1 - it's been on my to-do
> list to figure this out for a while now, sorry I haven't had a chance
> to get to it.

While checking the documentation, I noticed that in SDEN-1786925, 
document version 19.0 describes the errata as fixed in r1p1.

> 
> > Introduce this patch to avoid performance degradation caused by
> > restricting features on unaffected revisions.  
> 
> I'm curious, can you clarify the performance impact? At the time I
> was pretty sure that the ARM_SMMU_OPT_CMDQ_FORCE_SYNC was just for
> safety and never likely to be hit in practice, since with range
> invalidations any unmap should never end up with anywhere near 16
> TLBIs in a single batch anyway. Is that no longer the case?
> 

Based on the mailing list, the SMMUv3 implementation now fully supports 
the Broadcast TLB Maintenance (BTM) feature as part of the Distributed 
Virtual Memory (DVM) protocol. This allows CPU TLB invalidation instructions 
to be received by the SMMUv3, which is highly beneficial when the SMMUv3 
shares page tables with the CPU (e.g., in Guest SVA use cases).

Additionally, while this aligns with the SDEN documentation, 
please note that we do not have actual benchmark data at this time.

> > Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 +++++++-----
> >   1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c index
> > d16d35c78c06..7eadb27eb9be 100644 ---
> > a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c +++
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c @@ -4272,11 +4272,13
> > @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device
> > *smmu) smmu->features &= ~ARM_SMMU_FEAT_NESTING; break;
> >   		case IIDR_PRODUCTID_ARM_MMU_700:
> > -			/* Arm erratum 2812531 */
> > -			smmu->features &= ~ARM_SMMU_FEAT_BTM;
> > -			smmu->options |=
> > ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
> > -			/* Arm errata 2268618, 2812531 */
> > -			smmu->features &= ~ARM_SMMU_FEAT_NESTING;
> > +			if (variant <= 1 && revision < 0) {  
> 
> revision is unsigned, it cannot be < 0. This just breaks the
> workarounds entirely.
> 

Logic error: if (variant <= 1 && revision < 0) should be updated to revision < 1.


> Thanks,
> Robin.
> 
> > +				/* Arm erratum 2812531 */
> > +				smmu->features &=
> > ~ARM_SMMU_FEAT_BTM;
> > +				smmu->options |=
> > ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
> > +				/* Arm errata 2268618, 2812531 */
> > +				smmu->features &=
> > ~ARM_SMMU_FEAT_NESTING;
> > +			}
> >   			break;
> >   		}
> >   		break;  
> 
> 

Best regards,

JerryDai.
