Return-Path: <SRS0=la/L=VW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CED0C76190
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 22:53:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CCD229F9
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 22:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="XWNXqt90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CCD229F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 94739B50;
	Thu, 25 Jul 2019 22:53:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 04030BA9
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 22:41:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
	[209.85.208.47])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 761E0701
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 22:40:59 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id r12so16801085edo.5
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 15:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=WwU+qmmONX1xncs/dqjryTVOii2Cg8vQ1P0Xrj2m4Ls=;
	b=XWNXqt90mFSyzc+X+7oOpk0EHywvw0IGdbaXaRtT4YCnTiKkxymDUvITUf/bJmO5lT
	UkXn/OC2VxJj6WYUt7Q3tp6fDRtj1GvMYR1IsdxnsKzg2hWhUvWFgDdkCHYXf2/ylIBZ
	KM4rZ9FVbs8E3OqVD0LDduQXDvkQQISV6U6NlHQ8CoZHjcPgh9TveM9VX10tKk8JnjYB
	QqzgE8aCpvhwZIKnpq9iFyMD/jedxWR5qdK/Qx+YRfltU70Axwr/k8eeo0mPt+skBmtO
	zQPzTh/PkBtCeRstsdGZgxjP+xLXn4zNQF2YBQdpx6tmq+SOXUD/UgHx92bOfBJB99Mq
	E5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=WwU+qmmONX1xncs/dqjryTVOii2Cg8vQ1P0Xrj2m4Ls=;
	b=jm4KKVT4a4n3dRtNE7LM5ODxpxYg+VD8dGG7J6YDWiS9NKIj6nka8sP8q5rve9bvJK
	CzS5qdXawsDLJUbsJA+nHOXtFF+LQyKzKTosi7sI8Dhxp/q4OwxOZXVR+WmKM83fi5UT
	NFxA4BucTNs2/U8sq3K+Ob02clsRlNr4+vQneGct5DaaVLMnIIv+BW66CsIdrqEQTqzi
	aNR2iPrHgPguZPd+1ckSY2O80ZbEepPWNusk5LqWmpWwTvoYJqzly0prrQvpFiQGHl8G
	aq3V8EQyUd/EVVMlRXXvS7RYL4LvF68yMJYNLmlFvyBlV26N9RPBTAOuo53NcFtUz5fD
	zScQ==
X-Gm-Message-State: APjAAAX0cAgVAJopBm//56ncNs11genxWf6lWAc+lxqXV1bpNUn7MFns
	bVsNxGEJe03HDSqJcA2lB440BR6GnUF/VdoRVnnFcw==
X-Google-Smtp-Source: APXvYqyWumtoNwM6H81+WqfXp5HSxOsYXo37QcqTJbOaO09cyQ9/Cy6hoqdjwF7C7mthGVgZ2mGsCC8hgfRoLYmMR/o=
X-Received: by 2002:a17:907:217c:: with SMTP id
	rl28mr69872497ejb.131.1564094457570; 
	Thu, 25 Jul 2019 15:40:57 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 25 Jul 2019 15:40:46 -0700
Message-ID: <CAEauFbw4GyJbT_FA_tAu_8aghz3zqqsV-KnPjVdT8kH0LqLFHA@mail.gmail.com>
Subject: Possible bug in intel_iommu_iova_to_phys() in
	drivers/iommu/intel-iommu.c
To: dwmw2@infradead.org, iommu@lists.linux-foundation.org
X-Mailman-Approved-At: Thu, 25 Jul 2019 22:53:45 +0000
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
From: Yonghyun Hwang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yonghyun Hwang <yonghyun@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hello,

It seems that intel_iommu_iova_to_phys() doesn't return a correct
physical address for a given iova. This is the latest kernel code for
the function.

static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
                                            dma_addr_t iova)
{
        struct dmar_domain *dmar_domain = to_dmar_domain(domain);
        struct dma_pte *pte;
        int level = 0;
        u64 phys = 0;

        if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
                return 0;

        pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
        if (pte)
                phys = dma_pte_addr(pte);

        return phys;
}

As it can be seen above, pfn_to_dma_pte() returns PTE for (iova >>
VTD_PAGE_SHIFT). Therefore, I think (iova & (VTD_PAGE_SIZE - 1)) needs
to be added to phys. In addition, I think we need to take into account
level, if it is greater than 1. What do you think about the following
code?

        const unsigned long pfn = iova >> VTD_PAGE_SHIFT;
        pte = pfn_to_dma_pte(dmar_domain, pfn, &level);
        if (pte) {
                phys = dma_pte_addr(pte);
                if (level > 1)
                        phys += (pfn & ((level_to_offset_bits(level) << 1) - 1))
                                << VTD_PAGE_SHIFT;

                phys += (iova & (VTD_PAGE_SIZE - 1));
        }

Can this be a fix to make intel_iommu_iova_to_phys() work?

Thank you,
Yonghyun
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
