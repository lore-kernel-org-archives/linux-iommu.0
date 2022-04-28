Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC2DC433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 15:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BF374025A;
	Thu, 28 Apr 2022 15:41:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qf8kqcDswvPF; Thu, 28 Apr 2022 15:41:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B27D44059D;
	Thu, 28 Apr 2022 15:41:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A28BC0039;
	Thu, 28 Apr 2022 15:41:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DD8BC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:41:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B253403F7
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:41:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Uw-nruHTMEu for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 15:41:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7AA5C40198
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651160510; x=1682696510;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1fZnef+Z4Phdq1z0qR8KUJuGmesuoBu2lbBVrYU4ATA=;
 b=Sjo6qhXga/1pqbpjzR9xstfewtDyHJr3ubWMH5/fnTlUBvMXOhlgaYRl
 h+jxZ84JWj+klZGlbx9cRE/1c28h8p+MeBS9NbTffF2vAXfyyZUOjXA9A
 sO36jJJV48Kk2kwJwLmvmh/13SsSXb/VDUS2o+mC7TdL3PUTNIu5TQKu2
 SjIztKpzTJO37huNHokWRYaiXABCoqDcuQgFIQEVFpXjj50bJWx1w5J7p
 Npz34nNLT8fbynCeCc1c6wjKmirm+lZvzSDJMIkYXiFqxEjIK8iGy6HrH
 5M1uceD2dffykp45I7cFyqYM7Fm2+JABGnvRwgxQpfOwwrcz/Eq8cX7bE w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="266143336"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="266143336"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 08:41:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="559735568"
Received: from mpoursae-mobl2.amr.corp.intel.com (HELO [10.212.0.84])
 ([10.212.0.84])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 08:41:46 -0700
Message-ID: <60f31842-0cb9-bee3-dbfd-e0edf014f63f@intel.com>
Date: Thu, 28 Apr 2022 08:42:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To: Fenghua Yu <fenghua.yu@intel.com>
References: <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica> <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica> <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
 <bc18351c-27f2-17ae-e781-6b60fbb72541@intel.com>
 <YmqyeBfCuDXAMDlZ@fyu1.sc.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YmqyeBfCuDXAMDlZ@fyu1.sc.intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
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

On 4/28/22 08:28, Fenghua Yu wrote:
> Do you want me to change the changlog to add both this paragraph and the
> following paragraph?

Yes, as long as everyone agrees that it captures the issue well.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
