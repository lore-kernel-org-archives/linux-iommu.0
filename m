Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066C4C433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 16:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95461832D4;
	Thu, 28 Apr 2022 16:35:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pHgatV3sZA_U; Thu, 28 Apr 2022 16:35:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9239683323;
	Thu, 28 Apr 2022 16:35:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 262EBC0032;
	Thu, 28 Apr 2022 16:35:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC6CFC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 16:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B602F610DA
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 16:35:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aJS6wwTmD1xS for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 16:35:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 71DE461074
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 16:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651163725; x=1682699725;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=rcuXjMkF8Ip+u/ASCnj8P5Cfp+tPtitJogFYRQ+vRQI=;
 b=IiygfGc7kSK0RWnLKyLsmECaceBJx3sG/nfvOhxdXW/rAESJLraDW304
 RK3xu/psONe26UKYATaNE4weBw1BzhQP4HKH49LBfu1QD60qfkC6XLjDQ
 GIrmxx9HdtNXOXomKcpNVZ0HseZqT3pR60pyDKp0vjvjbL9Ferfl5/HHv
 mCns3K19MvWQD484AQiNtrHRdcKTCQQtCkg70ifBqA7Gd9COqaabgtTP3
 Ns/tC5EN715XaV+lsk6kBHJbDdj69tm0/A/me0DiFqyTZ6oOe7XSvk8oE
 xzLTDUN4iUn5L1HT9Sd7Ao37+kJpWKdBwekTn7beAm+VQjmxE/CAZP+xT g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="265194039"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="265194039"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 09:35:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="559761235"
Received: from mpoursae-mobl2.amr.corp.intel.com (HELO [10.212.0.84])
 ([10.212.0.84])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 09:35:22 -0700
Message-ID: <7ad996df-28ca-0aee-be23-e75bcca8d136@intel.com>
Date: Thu, 28 Apr 2022 09:35:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica> <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica> <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
 <bc18351c-27f2-17ae-e781-6b60fbb72541@intel.com> <Ymq6aZCTdrOE60cn@myrica>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Ymq6aZCTdrOE60cn@myrica>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, will@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, zhangfei.gao@linaro.org,
 Thomas Gleixner <tglx@linutronix.de>, robin.murphy@arm.com,
 Ingo Molnar <mingo@redhat.com>
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

On 4/28/22 09:01, Jean-Philippe Brucker wrote:
>> But, this misses an important point: even after the address space is
>> gone, the PASID will still be programmed into a device.  Device drivers
>> might, for instance, still need to flush operations that are outstanding
>> and need to use that PASID.  They do this at ->release() time.
> It's not really clear which release() this is. For us it's file descriptor
> release() (not MMU notifier release(), which is how I initially understood
> this sentence)

OK, maybe that should be: "file->release() time" to make it more clear.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
