Received: from mta0.migadu.com (out-166.mta0.migadu.com [91.218.175.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1912D38D407
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688356; cv=none; b=El6/btc5fib1gTGyxFtY3zRKa7tz2HqJVfopBYpsiKwtMhxfWiibCz/Q+6tz8hOEHn+NgVnP1QBRpqlmtaIT0QD+JImRRb7vabAl4G+jjJCMpVAr0F3neyz59J+fFrsTwgRL2nSXYebW07xmqTQHLQUHNO9vFFtlNlqyck+1eW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688356; c=relaxed/simple;
	bh=XbjAz7qal9P/BA1hWjjA2A6ymhlraYwWduqNMnGPNfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e42aolPq9Bbibk4jabZ7cM4JxY5l1azJVmA+0F5l8kdoEmzngzNpoVbo+6C5OT4A2E641x97gOVlmTbOWF2KlMtGESbP3rNQ001R6LicgDp5eIgkbuIC807Itvpx6BLkqDOaW6KoNbse2yG9TGaPSA9b4h6dCYYa6PEyion3qXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QG24ErEg; arc=none smtp.client-ip=91.218.175.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QG24ErEg"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=XbjAz7qal9P/BA1hWjjA2A6ymhlraYwWduqNMnGPNfM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787688350; v=1; x=1788293150;
 b=QG24ErEgpybMHabvymrLyO9+hTRr0wTiyYnw0miz0/bwUOjN8piTGcdjwy6cU24XnEU8ogK0
 +0TKYeNjDzd3twGpzzXwf2FDNv0M7EmuJguR8duaA2BVHCQmpls23eSDIvC3JjqLCnmnkm9qNQ9
 0+At40fQWGczb8kDFBEM+NAQ=
X-Envelope-To: iommu@lists.linux.dev
Received: from [IPV6:2a03:83e0:1156:1:10b7:9472:4142:b7b7] (2620:10d:c090:500::7:759c)
	by smtp.migadu.com with ESMTPS id 9b0c0d836eb66a38;
	Tue, 25 Aug 2026 20:05:50 +0000
X-Mizu-Trace-ID: 9b0c0d836eb66a38
X-Migadu-Flow: FLOW_OUT
Message-ID: <ddb64a7a-70b2-4c3d-8b80-2c7bcd7f329d@linux.dev>
Date: Tue, 25 Aug 2026 13:05:37 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] x86/mm/pat: CPA fixes
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
 David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jiri Slaby <jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>,
 Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Pedro Falcato <pfalcato@suse.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Steffen Dirkwinkel
 <lists@steffen.cc>, Suren Baghdasaryan <surenb@google.com>,
 Thomas Gleixner <tglx@kernel.org>, Toshi Kani <toshi.kani@hpe.com>,
 Vishal Moola <vishal.moola@gmail.com>, Vlastimil Babka <vbabka@kernel.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
 syzbot@syzkaller.appspotmail.com, x86@kernel.org
References: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
 <556337a8-5e2b-45fe-a1ba-90a90c1f3c4d@linux.dev> <ao1EtJG_Gj8f90WQ@gremlin>
Content-Language: en-US
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <ao1EtJG_Gj8f90WQ@gremlin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/25/26 12:31 AM, Lorenzo Stoakes (ARM) wrote:
> On Tue, Aug 25, 2026 at 12:12:32AM -0700, Atish Patra wrote:
>> Reproduced and verified this series (patches 1-3) on 4vcpu guest running two different kernels
>> 1. mainline (commit: 77ae27fd98f3)
>> 2. Ubuntu Resolute 7.0.0-26 (production kernel hitting the issue in a VM)
>>
>> The Reproducer consisted of
>> 1. A debug patch a cmdline-gated stall between the two *pmd reads in vmalloc_to_page()
>> 2. One taskset-pinned insmod/rmmod worker per module over stock cfg80211/dummy/veth modules
>>
>> With the above reproducer, both BUG within seconds in unpatched kernel.
>> 1. Resolute in 0.71s at alternative.c:2564 (BUG_ON(!pages[0] ...), RAX=0)
>> 2. mainline at alternative.c:2473 (BUG_ON(memcmp(addr, src, len))).
>>
>> With patches 1-3: zero splats across 10 runs each (600s/11,378 module load/unload cycles on mainline and 1200s/55,980 module load/unload cycles on Resolute).
> Amazing, thanks!
>
>>
>> Tested-by: Atish Patra<atishp@meta.com>
> I guess should be applied to patches 1-3 only strictly? Or perhaps 3/5?

Yes. 1-3 sounds good.


>>> --
>>> Sincerely yours,
>>> Mike.
>>>
> --
> Cheers, Lorenzo
