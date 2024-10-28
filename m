Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317C118DF7D
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730102657; cv=none; b=KPMAes3Bq7mGnb6K6zWeUp+iAlLE1KhY4xZxuKyHLyK13HYwudilCunOMuM2c0QaMzzU2Cr+CjZZfFjgv0fs/By9+ue59i9SPSboSw3e6KUoY3JFyKi7DIub69/2u/hvtVtQ8XRWuL2QT14IEr1S+3UeLwYMc1rbHTsYOg9OS94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730102657; c=relaxed/simple;
	bh=p6rK48nYUKGNYWK8dymIh1v4YV6ABvHs2RsfXgqGE9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwUaM89Ixn+PpMhE6kaMJognBXRRjDdgb4wtcHK1mm3YqgsoHbCuaGUSUuiolx4Nl60j65hv3Hac9IU2mGYtWdBya0Y1/dxprpSaG5oc4EBtff7CzW/6zR0fy6LFUFr+9NJHGggfMRcP2Iqqxy8JBQS56GASm722yUlii9klyLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dN3gTHU5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dN3gTHU5"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 434141140112;
	Mon, 28 Oct 2024 04:04:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 28 Oct 2024 04:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730102654; x=1730189054; bh=vh6Bqs3XhY31Rdd+eH9z0d7RfUwQ
	g80hOdmDGpnyyaM=; b=dN3gTHU5a6K7qe9F4uZhmfCic4UKC7TT7av+jbixAh0U
	ThpQz13q79C4RpOK0f8QW1vzAF0Mkv92RdtMxWGDdvblpX2pzxb7M/gN1seYzveK
	yqNpmYNT0GRpda43IyEy94GKFp4N0nNxMbYw9oBUjZsLEjYFwvcFJM1T4MPMpuyW
	2Ol1YN0bwOH+5pHTfFwedMVMegoq/EtUlTu/vLs5RAmfLQgmDQTeBB7ANOyTUNqf
	uGh7OhnXFICeNP4ewPbKnleBKjS/TFqFTFlMslT9y/pLlHI9S7dC9FEG+Wyh1Qt9
	UfzVsNMOnHQyC0abXbaHtLe9aEVC90WQwvJ0yuYpig==
X-ME-Sender: <xms:fUUfZ8Mf6LKlirkqBaRB3lUS7Doo2q2kj_ze2s0ujqifLs7942auBw>
    <xme:fUUfZy_UGGN4XjwP_RBkUgpCL5vtLXeSLO3-oVV6Ydhkj7At-sL-eAa-w4NzmljzD
    HPbVq3imR8dSSs>
X-ME-Received: <xmr:fUUfZzTq6NRQno8ByfdttI2py8jVu-PJ1t79L9-LzaNYJuLvnC_RrlVncyRT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrthgrlhhinhdrmh
    grrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehrohgsihhnrdhmuhhrphhhhies
    rghrmhdrtghomhdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhgpdhrtghpth
    htohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehiohhmmhhusehlihhs
    thhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepiihhrghnghiivghkuhhnuddusehh
    uhgrfigvihdrtghomhdprhgtphhtthhopehjohhhnhdrghdrghgrrhhrhiesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtohepughhvggvrhgrjhhkuhhmrghrrdhsrhhivhgrshhtrghv
    rgesrghmugdrtghomh
X-ME-Proxy: <xmx:fUUfZ0vcaS6GFCw896YuixOWmxS790Rnv0jut5ZdkJTDiziqrE_WhQ>
    <xmx:fUUfZ0fyZTpn6WuLfa-Gwxj-HVNeLTSr5ttwGw6aEF22Fi9YerEw9g>
    <xmx:fUUfZ42ObuEVrGg5DTuY5H9u9rYD7dqooHM8Wf5hBUl-tas0PIob0g>
    <xmx:fUUfZ4_xvnLSmW8emyRgXoe_5jb_HOGlGCAHT_tbpyL-RQUrpWpXZw>
    <xmx:fkUfZ86lqqvzn1Q3EZIbJ1BFcisrs02IMESSBkUlHdPDFGdkVbLyZ71n>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 04:04:12 -0400 (EDT)
Date: Mon, 28 Oct 2024 10:04:10 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhangzekun11@huawei.com, john.g.garry@oracle.com,
	dheerajkumar.srivastava@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
Message-ID: <Zx9Fepzvrs8b6_LX@shredder.mtl.com>
References: <cover.1694535580.git.robin.murphy@arm.com>
 <ZY1osaGLyT-sdKE8@shredder>
 <c9cf02b5-7add-46ea-8db1-46fdce191c1c@arm.com>
 <ZZ2AqZT4dD-s01q9@shredder>
 <ab22c439-e7da-49b5-b20b-856daf376c02@arm.com>
 <ZZ7atzgT6_kOvWnJ@arm.com>
 <ZZ-ky9UCoHwbyqfn@shredder>
 <ZZ-_LWz_4KxOkRsA@arm.com>
 <ZaFbPnDrYT5uGqJD@shredder>
 <ZaTb8KorPFPgRqD6@shredder>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaTb8KorPFPgRqD6@shredder>

On Mon, Jan 15, 2024 at 09:17:04AM +0200, Ido Schimmel wrote:
> On Fri, Jan 12, 2024 at 05:31:15PM +0200, Ido Schimmel wrote:
> > On Thu, Jan 11, 2024 at 10:13:01AM +0000, Catalin Marinas wrote:
> > > On Thu, Jan 11, 2024 at 10:20:27AM +0200, Ido Schimmel wrote:
> > > > On Wed, Jan 10, 2024 at 05:58:15PM +0000, Catalin Marinas wrote:
> > > > > Transient false positives are possible, especially as the code doesn't
> > > > > use a double-linked list (for the latter, kmemleak does checksumming and
> > > > > detects the prev/next change, defers the reporting until the object
> > > > > becomes stable). That said, if a new scan is forced (echo scan >
> > > > > /sys/kernel/debug/kmemleak), are the same objects still listed as leaks?
> > > > > If yes, they may not be transient.
> > > > 
> > > > We are doing "scan" and "clear" after each test. I will disable the
> > > > "clear" and see if the leaks persist.
> > > 
> > > If it is indeed a false positive
> > 
> > Looks like the leaks are transient. After removing the "clear" step the
> > leaks do not seem to persist.
> > 
> > > you can try the patch below (I haven't given it any run-time test,
> > > only compiled):
> > 
> > Will try and let you know next week.
> 
> Looks good. Feel free to add:
> 
> Tested-by: Ido Schimmel <idosch@nvidia.com>

Catalin, we have been using this patch since you posted it and haven't
seen any issues. Can please submit it upstream?

Thanks!
