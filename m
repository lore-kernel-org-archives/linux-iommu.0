Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64144C433FE
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 14:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 04D9040571;
	Mon, 25 Apr 2022 14:16:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uz5XEsNdCVQ1; Mon, 25 Apr 2022 14:16:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C6BC7404F7;
	Mon, 25 Apr 2022 14:16:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E87CC0032;
	Mon, 25 Apr 2022 14:16:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC337C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 14:16:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A89CD8242D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 14:16:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 087hEQJwrCAm for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 14:16:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2476782410
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 14:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650896205; x=1682432205;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=AAEEDt7xXTl7wGJqN1W/OSkx+JBqKQDu+fVaYieXLSM=;
 b=ikzVdQquMrRPfyOjw0yFoDZ+2U7TuermusoL6dyuMzMEvN2v8XLN5Upg
 y+iHYQW9xGPCeo3hWSqeqafZwK0vBXVVImLqYopoeu61eKv9SpsE7s7o9
 5ciLrFJagRdmqnTjYe4uqE7x3BwwAqx/HkbT/r9sEl5zeDmQ25qFV3nVT
 9Asd02ychWc/htcHOcMZ4031RITwlAGcH90lHnUVx7EEBc7HW8FbZiGLa
 u2+vsAZcYDN55lXbj+Nh9hWYrBg8TFJA5wG80ESoHvx7p5eX50hcrCKhv
 xsTsCywZ3lm5ip+uhVnKbFf7EfPdPDQyfGY+iL8Wa7dJLwBQLljruvmJ1 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="290396480"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; d="scan'208";a="290396480"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2022 07:16:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; d="scan'208";a="595254808"
Received: from bjkrist-mobl.amr.corp.intel.com (HELO [10.212.88.70])
 ([10.212.88.70])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2022 07:16:43 -0700
Message-ID: <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
Date: Mon, 25 Apr 2022 07:18:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
References: <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com> <YmA4pbgevqln/jSO@myrica>
 <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Yman5hLomw9/c+bi@myrica>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, robin.murphy@arm.com,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, zhangfei.gao@linaro.org,
 Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
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

On 4/25/22 06:53, Jean-Philippe Brucker wrote:
> On Sat, Apr 23, 2022 at 07:13:39PM +0800, zhangfei.gao@foxmail.com wrote:
>>>> On 5.17
>>>> fops_release is called automatically, as well as iommu_sva_unbind_device.
>>>> On 5.18-rc1.
>>>> fops_release is not called, have to manually call close(fd)
>>> Right that's weird
>> Looks it is caused by the fix patch, via mmget, which may add refcount of
>> fd.
> Yes indirectly I think: when the process mmaps the queue, mmap_region()
> takes a reference to the uacce fd. That reference is released either by
> explicit close() or munmap(), or by exit_mmap() (which is triggered by
> mmput()). Since there is an mm->fd dependency, we cannot add a fd->mm
> dependency, so no mmget()/mmput() in bind()/unbind().
> 
> I guess we should go back to refcounted PASIDs instead, to avoid freeing
> them until unbind().

Yeah, this is a bit gnarly for -rc4.  Let's just make sure there's
nothing else simple we can do.

How does the IOMMU hardware know that all activity to a given PASID is
finished?  That activity should, today, be independent of an mm or a
fd's lifetime.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
