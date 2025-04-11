Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0863814F9FB
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379111; cv=none; b=hanAxfUCT9vp7G3jlXDzxdv+NXW/4Ph5bQnfhsPJ2o1ulg2NKB7E9rnFgB0hyRJldzCkqcfEadRaphDsAz/d5jLZgPGBOcxDqnY0Oe4nPKFR84nEmkzl13bjTLE2CDrBr9AZt+Xl6RDjOBlFaJNZ20FJzdx5ZHz2rsvedwGv1Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379111; c=relaxed/simple;
	bh=vLuRATbx5LDdV1s+gmZGpChPGJUnQoaa6Eg1ufRT58g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=O5NKMoVaVXEMdMBEC9/vb29/UqNL2FIcawiTdH90ZdthTsWbaJvKYgfcP5fT3C1nUBTww3AaIaucIliRrxt6pPz0iM2GdYXAnljvS55e6b+v2yXEevb0dZsmAXPv/bSPm349l8aNv9JTpCRfgDpb4JRFBUPbTixXSCtvg3Hpvp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jZH1erNk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OVpoLqkU; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jZH1erNk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OVpoLqkU"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1D78B1140259;
	Fri, 11 Apr 2025 09:45:07 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Fri, 11 Apr 2025 09:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744379107;
	 x=1744465507; bh=FnpogYSibsZIjLuVr6OHFEsDolmRPgMsSOQs9WMEleo=; b=
	jZH1erNkGDdoo+8ELmjvhKmHM56/XhZr6ePrPW2NG4o0a7iuzINfEVnJM0Ju/app
	XMEJOGOsyTh0vgSTf/QOID/tr5ntYYni5AVAV4gllezNpdjky10u0I5uSfeff4af
	80kpbJfqQ9HEGzfs7sWZwJWTg4NB4U5BLgDVQWgMJYLCpRngrd9Z8L871UDtYrod
	i2i42DvtlAcHyRaLFxWaUZvSQx8cGNUX5TQ5USq/kJ9yYA/jL9IneIJa6Wj4FhzG
	1m1jnhhLjc9jGlaVaEsZIkT9KXdDmb7ryMZtYcYRcAXyV+mfvurPskmuadieliXD
	KLZhKwsyyZIo1jHdamAIfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744379107; x=
	1744465507; bh=FnpogYSibsZIjLuVr6OHFEsDolmRPgMsSOQs9WMEleo=; b=O
	VpoLqkUF+YW/6gJhRYF62kEN2EgNcF777xNU/x48KBk984a8k8fW1btirX3i0RB/
	QlziQhp8RS68KjfJ8tdD7ZLJW2PXIw5XZhvv2qEgZEPtpxCtioIEfNGBvnqH9vy5
	eOizgvdgpOTjWOG2L5LVX4EVRE7w3k/N5FvikcLkGAN1gxkbif5J7QQSYSUpzLOB
	8+r4Th9CZotz3ScETnxyxJL9Whm15/Isez45jC6eQ8gm7kSAAxabSoqffjz7hzvv
	CgmCI67a2minPIB59TCEh04yP2yDXYTiRExPtHFjO86oGYKM8q9eNNbg8AaQ/KuX
	5p3rSQwop9qMG+D7RvSwg==
X-ME-Sender: <xms:4hz5ZwiYXQy_HpXPmJ_0VgQPfKNqO1Tx9IXy3GVjxDavnINRNHjKRw>
    <xme:4hz5Z5AHx7nj7Kkj3o9rLeIl7dULfTP78m5bnAtJRbacdjkaQphVsiS0jTJRRODQU
    MtSFZud8dr5VuaUP2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudduleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    uddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhroheskegshihtvghsrd
    horhhgpdhrtghpthhtoheprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghp
    thhtoheprhhosggutghlrghrkhestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepsh
    hmohhsthgrfhgrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkvghvihhnrdhtihgr
    nhesihhnthgvlhdrtghomhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtph
    htthhopehiohhmmhhusehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:4hz5Z4HwqbqPWxwuAJu6wbo0cUbsEU0JtxlevWtaf_FIeER0WY3-jg>
    <xmx:4hz5ZxS5PgKv95zBM-X952-vxxqNzh7vpvCaGH_n55p-U2KbpeFTFA>
    <xmx:4hz5Z9yJsIE3ibPySn6XAlNfEhsJ2QC-FMfgoCstkkmzZAunWxgWvQ>
    <xmx:4hz5Z_72vDNtUntyfNl_Flauot27qnFa0UtYYy277QcCgto2wUlb1Q>
    <xmx:4xz5Z6hLPy-HUB0VDSe7B8qNLfy2F3ivwTMnZhKunOLiHyT6nZmA8q0F>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6AACB2220073; Fri, 11 Apr 2025 09:45:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: T9a37218b235c564b
Date: Fri, 11 Apr 2025 15:44:45 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Robin Murphy" <robin.murphy@arm.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Joerg Roedel" <joro@8bytes.org>
Cc: "Mostafa Saleh" <smostafa@google.com>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Kevin Tian" <kevin.tian@intel.com>, "Rob Clark" <robdclark@chromium.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-Id: <9c010a5d-a2a7-4002-9411-58009c1a21c8@app.fastmail.com>
In-Reply-To: <60c980c1-16b6-460e-89a4-203e9f0cbf3b@arm.com>
References: <20250411125423.1411061-1-arnd@kernel.org>
 <60c980c1-16b6-460e-89a4-203e9f0cbf3b@arm.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: dynamically allocate selftest device struct
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Apr 11, 2025, at 15:19, Robin Murphy wrote:
> On 11/04/2025 1:54 pm, Arnd Bergmann wrote:
>> @@ -1433,15 +1434,17 @@ static int __init arm_lpae_do_selftests(void)
>>   	};
>>   
>>   	int i, j, k, pass = 0, fail = 0;
>> -	struct device dev;
>
> Could we not simply make this static? Per the comment it's only here to 
> serve a NUMA node lookup buried deep in the pagetable allocator (TBH my 
> first thought was to just put an int on the stack and contrive a pointer 
> as the inverse of dev_to_node(), but I decided that would probably be 
> too contentious...)

A static device would work here, but that has other (small)
downsides:

 - static devices are discouraged for any real purpose because
   of the problematic lifetime rules. I think Greg would still
   want to eliminate these entirely.

 - there is slightly more memory usage: the __init function
   gets eliminated after boot, while a static allocation says
   around. It could perhaps be made __initdata.

 - If we ever need anything beyond the NUMA node from it, the
   dynamic allocation is probably close enough to make that
   work.

>> +	struct platform_device *pdev;
>>   	struct io_pgtable_cfg cfg = {
>>   		.tlb = &dummy_tlb_ops,
>>   		.coherent_walk = true,
>> -		.iommu_dev = &dev,
>>   	};
>>   
>> -	/* __arm_lpae_alloc_pages() merely needs dev_to_node() to work */
>> -	set_dev_node(&dev, NUMA_NO_NODE);
>> +	pdev = platform_device_alloc("io-pgtable-test", 0);
>
> Otherwise, this would seem to be another perfect case for the new 
> faux_device.

Good point, that is clearly better than platform_device in this
case. Shall I send a new version with that?

     Arnd
