Return-Path: <SRS0=+KdK=3D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB75C33C9E
	for <iommu@archiver.kernel.org>; Tue, 14 Jan 2020 16:31:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7EB24658
	for <iommu@archiver.kernel.org>; Tue, 14 Jan 2020 16:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M0rGSjX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7EB24658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 539E28614D;
	Tue, 14 Jan 2020 16:31:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ai-WIi08EBET; Tue, 14 Jan 2020 16:31:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 40DC786123;
	Tue, 14 Jan 2020 16:31:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E3C2C1D83;
	Tue, 14 Jan 2020 16:31:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D440BC077D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 16:31:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C15CA87985
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 16:31:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ILxzwQEAY8ZM for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jan 2020 16:31:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E6CEB878FE
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 16:31:07 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id g17so12810553wro.2
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 08:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nIBJ+W2XCD+RKINYx9xkIa8YvUMMciM9OXCElPBSqto=;
 b=M0rGSjX9nhYA7xN6pq7nhN6GCQ/pfDUlb4rdJCSHj6D+yjeHRwNaicItFWdsW8JbyT
 0r2ZOLTPD4PiLhKBQP+gQi3RfUVO8CPvNNeGmJYcQZsBNoaUF+rmB9LeAdDXtYoTAs3z
 /M1wPatIKp5y/+wVTpYms7hkx+ApHpcYj3Ty2BCTxMnBE26KXcbIZuRLQWJKDUism3aC
 xcmD0s0/v47kD/d6AfPrCR3HWlQ6APhaS4fwC4dlUmgTCHyCQHB83AVLmEbcEqm7Cwlb
 WeokJ+UT1R5DNUZMf2Ox/rwDuSmxPny71TIZNSbBI/CKjU78aXO6zyLB4mt0lwBIkwBK
 Kv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nIBJ+W2XCD+RKINYx9xkIa8YvUMMciM9OXCElPBSqto=;
 b=FVW/10Ggfs188VIxovxlIrhPQWixJdCHcaAXLCOM4fOgt8UbxV3aD3WzfjHHjJMr5x
 iC4gEE4BXah4sm9cu608P+w9HNzaH2x8482pza5vA5cN4q/a0EjnAiYg2gTBw91Ytgl9
 mhAdlW6FGZkTgzYYs6QNAJwi0ejuPPod5qfGdoaVva8zZ6BMdpB3jIBtXyWeBTuxWifd
 8mAaOxwpPHSZdaGwnNwqYQz4Eq0ErEG4ETzvyEW8RW5XCJNATBpqbXSaR1hRCQvaUum0
 TBWwzTK/3fKsOfy4YmFezxUBhgrQb3+dWJgRe93Ho7ku8wdOUhsALGIjIfR4o+Eg3xUo
 4jEg==
X-Gm-Message-State: APjAAAUvt+8Yq38CEMgF6Zb1Em1RNEWN9xG6Bl0YOtYDtfk700kHvOEH
 oe2aNd9VujM+BSdcE1p632HBvw==
X-Google-Smtp-Source: APXvYqw0/eegQ0zcb+toj+yn2h4NywBCJ2IMJC+LicnhxZZ6kzhHXcoqIC9Hr1rNQ6HwLknQccYolQ==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr26754664wrm.13.1579019466232; 
 Tue, 14 Jan 2020 08:31:06 -0800 (PST)
Received: from myrica ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id a16sm20643732wrt.37.2020.01.14.08.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 08:31:05 -0800 (PST)
Date: Tue, 14 Jan 2020 17:31:01 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 09/13] iommu/arm-smmu-v3: Prepare for handling
 arm_smmu_write_ctx_desc() failure
Message-ID: <20200114163101.GB5319@myrica>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20191219163033.2608177-10-jean-philippe@linaro.org>
 <20200114124247.GD29222@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200114124247.GD29222@willie-the-truck>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 sudeep.holla@arm.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, guohanjun@huawei.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Jan 14, 2020 at 12:42:47PM +0000, Will Deacon wrote:
> On Thu, Dec 19, 2019 at 05:30:29PM +0100, Jean-Philippe Brucker wrote:
> > Second-level context descriptor tables will be allocated lazily in
> > arm_smmu_write_ctx_desc(). Help with handling allocation failure by
> > moving the CD write into arm_smmu_domain_finalise_s1().
> > 
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index e147087198ef..b825a5639afc 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -2301,8 +2301,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
> >  	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
> >  	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
> >  	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
> > +
> > +	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
> 
> Hmm. This ends up calling arm_smmu_sync_cd() but I think that happens before
> we've added the master to the devices list of the domain. Does that mean we
> miss the new SSID during the invalidation?

Yes, the arm_smmu_sync_cd() isn't useful in this case, it's only needed
when the STE is live and arm_smmu_write_ctx_desc() is called for a
ssid!=0. On this path, the CD cache is invalidated by a CFGI_STE executed
later, when arm_smmu_attach_dev() installs the STE. I didn't want to add a
special case that avoids the sync when ssid==0 in because a spurious sync
probably doesn't impact performance here and arm_smmu_write_ctx_desc() is
quite fiddly already.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
