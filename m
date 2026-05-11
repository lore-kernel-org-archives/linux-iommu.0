Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C433112BD
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492823; cv=none; b=ZW5zEHWX7vD/lkBAKTd0VbNZPb4yJC9n2KAy4t2eFwQSwbh+SImU9aJuacGHKPdsCnOAct0zEKEsEaKZb8KUCriHj9FLXmEVPdjL7UxuC70JnKJOLHgXDR9uw/GfWl6JnlztO7towwQLt+81ukzzq0Vz8rTz1wFNkyXq1YgIVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492823; c=relaxed/simple;
	bh=D/4Zbemo5vF6p8/soVP/ycbQ3QKW1LUgg1CBMUjbR4M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Vj7S2mCggAfAgKZn5A16XzZYVb+Z5x1Y74I7Eo+W+w6pgEAB8O6CNA3P7MLjy0XQGx/k6bhN+QK42JlPEEqSxvsBQ67o8CACauuQPVuLVAFlChVUBt0WoTIgx/W3QnRKAUmY23orcvXZAPSOjJwYbSgNHypExpIyl5TVn/yRhc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VYi7BEnD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BNlQW2Gr; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VYi7BEnD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BNlQW2Gr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 55AD81D0008D;
	Mon, 11 May 2026 05:46:59 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-04.internal (MEProxy); Mon, 11 May 2026 05:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778492819;
	 x=1778579219; bh=TWbx4nQ+++QmGm3BfnUj9UQpSo0jVkGk9GjwYWuvoTU=; b=
	VYi7BEnDHXsoCVNn8uAHpzegR2U06vS3kxBHRDjdgsgpn4XocWQS/m43V/TMKkE2
	e5lQ5bOLm0rbl4JxIueQLb/Sl8Xnts9WZnvVgoluMu+STKdBlAtGkE5R7aBeESUY
	Hm/w413898OLbphdoFR/1436vg2g9U0WNXt+38DXNL9KcC7mKcExOWBFc1PaKZVR
	kDo7YzQfFYzAFGTegQ7WJA/Dxzezbki6vMoSC6daX87ufZbuPM5ttd4O752S7tKT
	fuAIUy87Z37FH4+xPWg1UGbY0u/NHxxALMDpIVzrCjyWDUnhJgJ4VvdBNS+07aRU
	fkJCtXeGAfOfqcWyLU2VOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778492819; x=
	1778579219; bh=TWbx4nQ+++QmGm3BfnUj9UQpSo0jVkGk9GjwYWuvoTU=; b=B
	NlQW2Grt5sdDGAfhfXCUos5Nd0wO9gEEOI1eHqKKtn5YsYgkWlFJ8gD5ThPI7/86
	pyrueeUHVXyIOLPlldJHtn/yGZwo3uEfCYSmKkiy392tqPsZlIL2S6PQTTvgU651
	r0+9lr2rSju+YPu/bfxihkehEMjfSvj0qy0SabkM+h7y3Z2PXctsTsSN6x+DpyFt
	D27MJYUuvUA8gCDp5tXboN9YBcfYSho40aITxanS/XbujAYymK2vz0mN8pEYcyUp
	zfd4xYSVmB3i71AP6609SdPp+SwmuS6I+9kl9qqKAMMciyT8yCxxcBK7eiHe9kpA
	dpxht0Q+V/cC10BEAOURg==
X-ME-Sender: <xms:kqUBat8gcYJgArWQcSWbTE7Aa2nMyJAH1UzTytzG42AiKLkxKRKATQ>
    <xme:kqUBasgs1ris0F51SOgVf4QmhZgKjLeQQOn2LchB-xWJDuW1QWRDoLUkeMUFmUiPe
    1EmX6Gk5JSKJb6Hk2u8Gi516wuyPZWt_nIM-BDO8b1FnI0di9--gVo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhgpdhrtghpthhtoheprhhosg
    hinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehtghhlgieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsihhgvggrshihsehlihhn
    uhhtrhhonhhigidruggvpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhi
    shhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehiohhmmhhusehlihhsth
    hsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:kqUBagiXrMjUWsphcDn9l_ykZ6fT9l-kXe6cM57h_CcpVQvtT4UznA>
    <xmx:kqUBahOP_25gZ4nlAviyGUrJFh0WCiOsvj-zdJ_sziCFNyN5_KpOuA>
    <xmx:kqUBajq_WcZabBNsLNpFZtU7aqdJxv9O-NjNmvsmUn_YI6faMAz_RA>
    <xmx:kqUBar4N9Q2O8-S3EQ1prwObWx_vX2qx6-UKiRVzIbSgUkmv6GXbIg>
    <xmx:k6UBas14nptktwBJRQXCDf7_S7BI-JTL-lDjAu-AZRb7jFSlAROnzGKm>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9A9791060065; Mon, 11 May 2026 05:46:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AVHaR-kDAB-J
Date: Mon, 11 May 2026 11:46:29 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Gleixner" <tglx@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>,
 "Joerg Roedel" <joro@8bytes.org>, "Andrew Morton" <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Message-Id: <34af0db2-7a04-4119-925f-3aa3e3ecb683@app.fastmail.com>
In-Reply-To: <87y0hq8lcu.ffs@tglx>
References: <20260203162406.2215716-1-arnd@kernel.org> <874ikf9i34.ffs@tglx>
 <d52dcd45-959a-4ff4-9e82-0bae133785f1@app.fastmail.com> <87y0hq8lcu.ffs@tglx>
Subject: Re: [PATCH 1/2] [RFC] debugobjects: avoid gcc-16.0.1 section mismatch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, May 11, 2026, at 09:18, Thomas Gleixner wrote:
> On Mon, May 11 2026 at 08:17, Arnd Bergmann wrote:
>> On Sun, May 10, 2026, at 21:31, Thomas Gleixner wrote:
>>> On Tue, Feb 03 2026 at 17:23, Arnd Bergmann wrote:
>>>> WARNING: modpost: vmlinux: section mismatch in reference: lookup_object_or_alloc.part.0+0x1ac (section: .text) -> is_static_object (section: .init.text)
>>>>
>>>> From what I can tell, the transformation is correct, as this
>>>> is only called when lookup_object_or_alloc() is called from
>>>> debug_objects_selftest(), which is also __init.
>>>
>>> So clearly the compiler is buggy. It creates an __init specific copy of
>>> lookup_object_or_alloc() and then fails to attribute it correctly.
>>
>> I don't see what else the compiler is supposed to do, it has no idea what
>> __init means in the kernel, or what the rules are for calling between
>> that and normal functions. Putting a non-inlined lookup_object_or_alloc()
>> into a special section without an explicit attribute would clearly
>> be a bug.
>
> I agree that the compiler does not know what __init means, but this
> sucks as it leaves an unused copy of lookup_object_or_alloc() around
> after init.
>
> What happens if you mark is_static_object() with 'noinline'?

I've reproduced the issue with the release gcc-16.1.0 build,
and tested marking is_static_object (along with
dummy_tlb_add_page and dummy_tlb_flush from the other
instance) as noinline.

As expected, this avoids the problem as well.

      Arnd

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 40e33257d3c2..b89dcf167832 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -782,16 +782,17 @@ static void __init dummy_tlb_flush_all(void *cookie)
 	WARN_ON(cookie != cfg_cookie);
 }
 
-static void __init dummy_tlb_flush(unsigned long iova, size_t size,
-				   size_t granule, void *cookie)
+static noinline void __init dummy_tlb_flush(unsigned long iova, size_t size,
+					    size_t granule, void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
 }
 
-static void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
-				      unsigned long iova, size_t granule,
-				      void *cookie)
+static noinline void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
+					       unsigned long iova,
+					       size_t granule,
+					       void *cookie)
 {
 	dummy_tlb_flush(iova, granule, granule, cookie);
 }
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 12e2e42e6a31..18253cb03701 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1212,7 +1212,7 @@ struct self_test {
 
 static __initconst const struct debug_obj_descr descr_type_test;
 
-static bool __init is_static_object(void *addr)
+static noinline bool __init is_static_object(void *addr)
 {
 	struct self_test *obj = addr;
 
