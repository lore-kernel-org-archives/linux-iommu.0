Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04FBC10F0E
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 03:16:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66A6206DD
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 03:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66A6206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 723A3AD7;
	Mon,  8 Apr 2019 03:16:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BF904ACD
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 03:16:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2067A623
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 03:16:33 +0000 (UTC)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 9665736192FA5693B86B;
	Mon,  8 Apr 2019 11:16:31 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS411-HUB.china.huawei.com
	(10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Mon, 8 Apr 2019
	11:16:22 +0800
Subject: Re: [PATCH v4 0/6] normalize IOMMU dma mode boot options
To: Hanjun Guo <guohanjun@huawei.com>, Jean-Philippe Brucker
	<jean-philippe.brucker@arm.com>, John Garry <john.garry@huawei.com>, "Robin
	Murphy" <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, "Joerg
	Roedel" <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc
	<linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, "Gerald
	Schaefer" <gerald.schaefer@de.ibm.com>, Martin Schwidefsky
	<schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Tony Luck
	<tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, David Woodhouse
	<dwmw2@infradead.org>, iommu <iommu@lists.linux-foundation.org>,
	linux-kernel
	<linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, x86 <x86@kernel.org>,
	linux-ia64 <linux-ia64@vger.kernel.org>
References: <20190407124147.13576-1-thunder.leizhen@huawei.com>
	<b20fd8a6-88ce-7d26-8eb0-ed9f095988a6@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5CAABD03.9000301@huawei.com>
Date: Mon, 8 Apr 2019 11:16:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
	Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <b20fd8a6-88ce-7d26-8eb0-ed9f095988a6@huawei.com>
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190408031619.v4YSbGnJhBBvIxe-sfZVjvVf8w26tXsDfA9VobLwgxw@z>



On 2019/4/8 9:14, Hanjun Guo wrote:
> Hi Zhen,
> 
> On 2019/4/7 20:41, Zhen Lei wrote:
>> As Robin Murphy's suggestion:
>> "It's also not necessarily obvious to the user how this interacts with
>> IOMMU_DEFAULT_PASSTHROUGH, so if we really do go down this route, maybe it
>> would be better to refactor the whole lot into a single selection of something
>> like IOMMU_DEFAULT_MODE anyway."
>>
>> In this version, I tried to normalize the IOMMU dma mode boot options for all
>> ARCHs. When IOMMU is enabled, there are 3 dma modes: paasthrough(bypass),
>> lazy(mapping but defer the IOTLB invalidation), strict. But currently each
>> ARCHs defined their private boot options, different with each other. For
>> example, to enable/disable "passthrough", ARM64 use iommu.passthrough=1/0,
>> X86 use iommu=pt/nopt, PPC/POWERNV use iommu=nobypass.
>>
>>
>> Zhen Lei (6):
>>   iommu: use iommu.dma_mode to replace iommu.passthrough and
>>     iommu.strict
>>   iommu: keep dma mode build options consistent with cmdline options
>>   iommu: add iommu_default_dma_mode_get() helper
>>   s390/pci: use common boot option iommu.dma_mode
>>   powernv/iommu: use common boot option iommu.dma_mode
>>   x86/iommu: use common boot option iommu.dma_mode
> 
> This will break systems using boot options as now, and I think
> this is unacceptable. If you want to do so, just introduce iommu.dma_mode
> on top of those iommu boot options with dma mode boot options unchanged,
> and iommu.dma_mode is for all archs but compatible with them.

I just changed the boot options name, but keep the function no change. I added
all related maintainers/supporters in the "to=" list, maybe we can disuss this.
Should I add some "obsoleted" warnings for old options and keep them for a while?
But I think this kind of thing is best done in one go.

> 
> Thanks
> Hanjun
> 
> 
> .
> 

-- 
Thanks!
BestRegards

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
