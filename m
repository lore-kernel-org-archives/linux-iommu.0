Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9386525A655;
	Tue,  4 Feb 2025 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738649536; cv=none; b=KaoK6N9mTUu8tn2FwWlIKdh28egG4aYPmRHU5xWFdwJXt6RN+seXq80E6gnpxOpUxW0/mNvdGJKPZ3Xa3KWQV5Wze23mrtCDoO6MUKCcjqsALyBfdXc/ispMjgAmw+ddoDPhc9DL8KN1SUiH67Abc25a/MPPF54dZ6gEMCV0IPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738649536; c=relaxed/simple;
	bh=NRNC/SfbsPeODy6wGi7M72ozq3yOc1C+pIH3B9J2lzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c79YyFOhHkQ5PAJ9B6dhT3oTELeBnKN5NngghS8cE8XJrv9C7XH6WuafPWiKcddzMWRpI6ZYBSMOvAHNGCIrLbDZl09p1uDBRyA14HZzOKue9lLdEMFvHINz4uK7TocXj3z8Snkg7uQGDPYGcGRekT8y7Isv9PVTNgEr4zf3w50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A82C68AFE; Tue,  4 Feb 2025 07:12:09 +0100 (CET)
Date: Tue, 4 Feb 2025 07:12:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bruno Gravato <bgravato@gmail.com>
Cc: Stefan <linux-kernel@simg.de>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Christoph Hellwig <hch@lst.de>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Keith Busch <kbusch@kernel.org>, Adrian Huang <ahuang12@lenovo.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of
 AsRock X600M-STX + Ryzen 8700G
Message-ID: <20250204061208.GA29300@lst.de>
References: <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com> <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info> <20250117080507.GA25953@lst.de> <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info> <10e39c88-4667-4c61-b3eb-3dd7ee3074c3@leemhuis.info> <20250128074133.GA22435@lst.de> <379bba80-df0f-44c5-a15e-fd4393c52b8f@simg.de> <Z5jTKTfKUeLm4uJT@gallifrey> <e01fdde0-4760-487d-af0e-2aecf9d7ade2@simg.de> <CAOBLbT8V5DkuXzzgp2dPOZkGomqiLa_cdC=e=uWBtcWpP7L=Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOBLbT8V5DkuXzzgp2dPOZkGomqiLa_cdC=e=uWBtcWpP7L=Ww@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Feb 02, 2025 at 08:32:31AM +0000, Bruno Gravato wrote:
> In my tests I was using real data: a backup of my files.
> 
> On one such test I copied over 300K files, variables sizes and types
> totalling about 60GB. A bit over 20 files got corrupted.
> I tried copying the files over the network (ethernet) using rsync/ssh.
> I also tried restoring the files using restic (over ssh as well). And
> I also tried copying the files locally from a SATA disk. In all cases
> I got similar results with some files being corrupted.
> The destination nvme disk was using btrfs and running btrfs scrub
> after the copy detects quite a few checksum errors.

So you used various different data sources, and the desintation was
always the nvme device in the suspect slot.

> I analyzed some of those corrupted files and one of them happened to
> be a text file (linux kernel source code).
> A big portion of the text was replaced with text from another file in
> the same directory (being text made it easy to find where it came
> from).
> So this was a contiguous block of text that was overwritten with a
> contiguous block of text from another file.
> If I remember correctly the other file was not corrupted (so the
> blocks weren't swapped). It looked like a certain block of text was
> written twice: on the correct file and on another file in the same
> directory.

That's a very interesting pattern.

> I also got some jpeg images corrupted. I was able to open and view
> (partially) those images and it looked like a portion of the image was
> repeated in a different part of it), so blocks of the same file were
> probably duplicated and overwritten within itself.
> 
> The blocks being overwritten seemed to be different sizes on different files.

This does sound like a fairly common pattern due to SSD FTL issues,
but I still don't want to rule out swiotlb, which due to the bucketing
could maybe also lead to these, but I can't really see how.  But the
fact that the affected systems seem to be using swiotlb despite no
good reason for them to do so still leaves me puzzled.

