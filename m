Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294DDC433F5
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 15:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE69983F65;
	Tue, 12 Apr 2022 15:35:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WjYhkroV6uoa; Tue, 12 Apr 2022 15:35:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AAFCF83F55;
	Tue, 12 Apr 2022 15:35:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 805FCC002F;
	Tue, 12 Apr 2022 15:35:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90210C002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 15:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6EF556109A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 15:35:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LpNKtW1i9l7F for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 15:35:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A764361098
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649777752; x=1681313752;
 h=message-id:date:mime-version:to:cc:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=lj9QUXdM5GCMuPvK+BqdMIEkmXMFoN2VtIV9O9lZiCQ=;
 b=iniVuKkxRvTnQUOsODUFsiEQ0X3IH9yvSxQHt5ppDlaIXHBLxV12D4f0
 lh3tPHiu740cetLhrI3kunqcdbycN0MPWA2aeReTWcZYJKBAhcQmO/ATe
 uv+ME/Np6e12UpnxeZRD4e8JrEZ04HOTDlA6rxgFyUayiBp/PX2ngpbQk
 gvDB2fgYah3/HBcHOcl1+nfJb8dLcFm7n9GHmmGp3UVJaAbFYYSL0inBF
 46t3lKTDMaEh0AygoBi8esHs92ZLMfLKZ+LjyJzC1odCEn5t7lvgvv4FO
 m6CE7olpBIQq0Yg0IP3X11YnBj8XbYGx6MFzswio/1C4OqolbKpOxgP19 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="242342965"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; d="scan'208";a="242342965"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 08:35:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; d="scan'208";a="551758622"
Received: from vtelkarx-mobl.amr.corp.intel.com (HELO [10.209.191.73])
 ([10.209.191.73])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 08:35:50 -0700
Message-ID: <8b1e40c9-b2e8-7b73-d9ad-2c6a5a167370@intel.com>
Date: Tue, 12 Apr 2022 08:35:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220207230254.3342514-6-fenghua.yu@intel.com>
 <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <41ed3405-66d9-0cde-fc01-b3eacb85a081@intel.com> <YlWWavIDMNpbD3Ye@larix>
From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <YlWWavIDMNpbD3Ye@larix>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

On 4/12/22 08:10, Jean-Philippe Brucker wrote:
>> I wonder if the Intel and ARM IOMMU code differ in the way they keep
>> references to the mm, or if this affects Intel as well, but we just
>> haven't tested the code enough.
> The Arm code was written expecting the PASID to be freed on unbind(), not
> mm exit. I missed the change of behavior, sorry (I thought your plan was
> to extend PASID lifetime, not shorten it?) but as is it seems very broken.
> For example in the iommu_sva_unbind_device(), we have
> arm_smmu_mmu_notifier_put() clearing the PASID table entry for
> "mm->pasid", which is going to end badly if the PASID has been cleared or
> reallocated. We can't clear the PASID entry in mm exit because at that
> point the device may still be issuing DMA for that PASID and we need to
> quiesce the entry rather than deactivate it.

I think we ended up flipping some of this around on the Intel side.
Instead of having to quiesce the device on mm exit, we don't let the mm
exit until the device is done.

When you program the pasid into the device, it's a lot like when you
create a thread.  We bump the reference count on the mm when we program
the page table pointer into a CPU.  We drop the thread's reference to
the mm when the thread exits and will no longer be using the page tables.

Same thing with pasids.  We bump the refcount on the mm when the pasid
is programmed into the device.  Once the device is done with the mm, we
drop the mm.

Basically, instead of recounting the pasid itself, we just refcount the mm.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
