Return-Path: <SRS0=ThSx=EQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A75FC388F7
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 17:06:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1BA206D8
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 17:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1BA206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B222022CCE;
	Tue, 10 Nov 2020 17:06:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a+rKmbRwf9sB; Tue, 10 Nov 2020 17:05:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9F3B1203F6;
	Tue, 10 Nov 2020 17:05:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 893E2C0889;
	Tue, 10 Nov 2020 17:05:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A56D1C016F
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 15:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 88F0822C51
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 15:53:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CCNFk5V59Mu4 for <iommu@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 15:53:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id CF8E822C44
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 15:53:41 +0000 (UTC)
IronPort-SDR: 7PxbcY7sfnO3FR9xK0PcyU5ZcLEbAPh38Df0698CgxAt69us4IHP8PcJ0r+9XDoS/i1uHGiO2/
 V0xNBVjAAURA==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="170153698"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; d="scan'208";a="170153698"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2020 07:53:39 -0800
IronPort-SDR: dracVvCiK/bgswNxiYrBwOdkO98TtU2a9F4PJqB57gXg+uh8aL8UQ7fpvgZZrxzyGa//lle4MV
 SxRan/iDmzHg==
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; d="scan'208";a="531272516"
Received: from lhawrylk-desk.ger.corp.intel.com ([10.213.18.46])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2020 07:53:36 -0800
Message-ID: <4cfa1f1827e0ccbfbc94de3beba64a4a141b2248.camel@linux.intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: avoid unnecessory panic if iommu init
 fail in tboot system
From: Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>
To: Zhenzhong Duan <zhenzhong.duan@gmail.com>, linux-kernel@vger.kernel.org
Date: Tue, 10 Nov 2020 16:53:33 +0100
In-Reply-To: <20201110071908.3133-1-zhenzhong.duan@gmail.com>
References: <20201110071908.3133-1-zhenzhong.duan@gmail.com>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 10 Nov 2020 17:05:56 +0000
Cc: x86@kernel.org, tboot-devel@lists.sourceforge.net, ning.sun@intel.com,
 iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 tglx@linutronix.de, dwmw2@infradead.org
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

Hi Zhenzhong

On Tue, 2020-11-10 at 15:19 +0800, Zhenzhong Duan wrote:
> "intel_iommu=off" command line is used to disable iommu but iommu is force
> enabled in a tboot system for security reason.
> 
> However for better performance on high speed network device, a new option
> "intel_iommu=tboot_noforce" is introduced to disable the force on.
> 
> By default kernel should panic if iommu init fail in tboot for security
> reason, but it's unnecessory if we use "intel_iommu=tboot_noforce,off".
> 
> Fix the code setting force_on and move intel_iommu_tboot_noforce
> from tboot code to intel iommu code.
> 
> Fixes: 7304e8f28bb2 ("iommu/vt-d: Correctly disable Intel IOMMU force on")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> ---
> v2: move ckeck of intel_iommu_tboot_noforce into iommu code per Baolu.

I have check it on my TXT testing environment with latest TBOOT,
everything works as expected.

Thanks,
Lukasz

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
