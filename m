Return-Path: <SRS0=Z2AP=ZY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77855C432C0
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 02:24:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A7B20833
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 02:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A7B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0BDE5204EB;
	Mon,  2 Dec 2019 02:24:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4eAUdI441Wq2; Mon,  2 Dec 2019 02:24:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 191141FDAF;
	Mon,  2 Dec 2019 02:24:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A574C1DDC;
	Mon,  2 Dec 2019 02:24:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25102C087F
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 02:24:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1391986439
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 02:24:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zee-hQi8x6uI for <iommu@lists.linux-foundation.org>;
 Mon,  2 Dec 2019 02:24:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 80F25863A8
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 02:24:10 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Dec 2019 18:24:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,267,1571727600"; d="scan'208";a="222260750"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 01 Dec 2019 18:24:09 -0800
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:667!
To: Anand Misra <am.online.edu@gmail.com>, iommu@lists.linux-foundation.org
References: <CAL20ACJ2cM1Zs3q5rb3jG7fDVNfzySV6WX=+nbdKiS4KT52NaQ@mail.gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f0913338-3854-6ff7-aa8c-85b96efbed27@linux.intel.com>
Date: Mon, 2 Dec 2019 10:23:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAL20ACJ2cM1Zs3q5rb3jG7fDVNfzySV6WX=+nbdKiS4KT52NaQ@mail.gmail.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

On 12/2/19 9:46 AM, Anand Misra wrote:
> Hello:
> 
> I'm in process of adding iommu support in my driver for a PCIe device. 
> The device doesn't publish ACS/ATS via its config space. I've following 
> config:
> 
> Linux cmdline: "intel-iommu=on iommu=pt 
> vfio_iommu_type1.allow_unsafe_interrupts=1 pcie_acs_override=downstream"
> Centos kernel: 3.10.0-1062.1.2.el7.x86_64
> 

Can you please use the latest kernel for test? 3.10 seems to be pretty
old and there are a lot of changes after it.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
