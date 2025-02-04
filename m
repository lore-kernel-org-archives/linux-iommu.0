Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF834206F33;
	Tue,  4 Feb 2025 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738660393; cv=none; b=ECkzn5KkIbl7UmUv9vGh69QmYVX5J7SVv7yRCydWGT5zK/tTh8r28qps7BzTyHMId1LcSHB7GLJH1QloHlYEZ7J24bVnY8PbKTDqm9muCxec3DSi6xFQs45jyTkbJ1r2mXVRN6EUh5yDnWhaQ/B2wS/xxDk1vpgUFuzC4saJvcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738660393; c=relaxed/simple;
	bh=Zj7E2MeqphGb/FoGa7alLHmNq9sT8LOGDhFNQC0kVjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAUVVmJjrNRvm0aBwlLJqfWOLMDY4zDYGNV/IB7F54tlBSUF+MfjRwQH9kabMDvprY4dFf3QuTc4lrdM3991qJh8dWheI8EJkfACGuZLEhytOvNSPwL8B70NJR6w0H1XDb5XkY2cXHeZ7sTQQ57YO52VUJ9qpkIRO9hSuvzeB90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMWPVjQd; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMWPVjQd"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so8940975a91.0;
        Tue, 04 Feb 2025 01:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738660391; x=1739265191; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+AHMI1n0um1Uc2f0ky1zL1PO/sMw1al2b0gfWEzKF20=;
        b=dMWPVjQduAdIak9+vMyZlKLFS/I9Dz9Z6vEcRz+dfQZSC/0IAbLUyav7hKQT2Qr2zI
         8gaPdeb6LNoCpzPHoVoCQvH0nRAD70MjDD/avrC6Jj+1Ri+UtVHJxmTvsFu/NU3V72bQ
         IoqaeUX9iVoaSB4RzeFEaq3LUOm8wxhkFu0vNFu9DJDe322CxyneTBH9QorSwHxeGfJw
         WLkuq6yeq6K4TcgJ+pxu1Xk8fI0eMUqurOx7PSDs+w90kEZcT32I2xzmeNcFXjPFb+ml
         GO9wAqrrFMYx7ifacDck3YbsD91sO0TJq7NKqG/ijZBxedYUGOnvC4Ti7S/wahvxlE26
         kG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738660391; x=1739265191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+AHMI1n0um1Uc2f0ky1zL1PO/sMw1al2b0gfWEzKF20=;
        b=oLW1xfJEXkgb92UYFihWfxXheT8sR2MsZyZLPy+4VQOL5S0mosBdDukK+rESBSMvlM
         taJCepP9hjfePKjHFk4mR/olzR5pef7sXejuJk+rgHtWyQWEuqUQEfuTPOkFafHsi48S
         BoHLHOvtNBK0cphy3JhqG9esheh6wChBnuiB04bNyUj7MDJIcYJ8xoV5rjzgV0DgUxhZ
         tAeeBTvodMwsMEM0qQww83us0ydr3YPtHIsuGgu35EbFFfmixxaTIOhabCLKyggABaiq
         RuCgniDTJTOgenn2K/RNq58ryRfDMR8WyDXHuf+WVj/MxfX00KdfwWpv9t2j9slXjlWK
         fkPw==
X-Forwarded-Encrypted: i=1; AJvYcCV7WOJhQi692LgPBEEpXov6Y2RKUMUXoENRil2bHOnteRmlZ5MfPeDKKjDAweg4rWeh2nUl8rNl3t9mzWA=@lists.linux.dev, AJvYcCVehH/bhAcr05ts2zxAdKjndj+StaGA1HYhdD3LzLiphK6odzAtKiiIc1k2dRu+rlb7CZ660w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2mdaZ3oGQF6ZTKumcENd2ygPkD8g88hACPUkuEsqFGPc9l0/7
	8nNgLmVX8yVnNdiQxhaGvM++Gk6/gcJ88zuRry2vnB6kPwFIa275BN/1HKkIMHUnHOEZiBbBwU9
	QI1M8Hj6lM+PmZN84fg7A8tYlGxg=
X-Gm-Gg: ASbGncvRKnaRReaHajdwBF+5NRpHf/ioJPruKnvpYX932H86yCEHKXG9Nzil265AwmD
	o0BRPW7E5u+UsLGUdgKDTKwOYocA3jF/44uwKU0eZAdy5LpY/9F58ZRY4igKvhRH2UDsIad7AT5
	Mox/xvELUUCVd1xP3JCmp5Y/ke3uQ=
X-Google-Smtp-Source: AGHT+IEjr+5p9ULMzoc/xpn7zcsHmFh9pQft0Sd8GQkkXIpsHHX4xJoLdzK+6o4pH/qlQ/u3VVH/AFYlbacH5FUEJZE=
X-Received: by 2002:a17:90b:51cc:b0:2ea:498d:809f with SMTP id
 98e67ed59e1d1-2f83ac5e467mr32092446a91.26.1738660391086; Tue, 04 Feb 2025
 01:13:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
 <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info> <20250117080507.GA25953@lst.de>
 <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info> <10e39c88-4667-4c61-b3eb-3dd7ee3074c3@leemhuis.info>
 <20250128074133.GA22435@lst.de> <379bba80-df0f-44c5-a15e-fd4393c52b8f@simg.de>
 <Z5jTKTfKUeLm4uJT@gallifrey> <e01fdde0-4760-487d-af0e-2aecf9d7ade2@simg.de>
 <CAOBLbT8V5DkuXzzgp2dPOZkGomqiLa_cdC=e=uWBtcWpP7L=Ww@mail.gmail.com> <20250204061208.GA29300@lst.de>
In-Reply-To: <20250204061208.GA29300@lst.de>
From: Bruno Gravato <bgravato@gmail.com>
Date: Tue, 4 Feb 2025 09:12:54 +0000
X-Gm-Features: AWEUYZklsTO1DdX17XI0s3UrJDzPBR2NguTIOGWaQniEHqaiG2AWZWpwapwJWK0
Message-ID: <CAOBLbT_kn+5H-+RYM1UOAkxhfJnpqKMNv9_d_Ys9CgY_=TcdsA@mail.gmail.com>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Christoph Hellwig <hch@lst.de>
Cc: Stefan <linux-kernel@simg.de>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Thorsten Leemhuis <linux@leemhuis.info>, Mario Limonciello <mario.limonciello@amd.com>, 
	Keith Busch <kbusch@kernel.org>, Adrian Huang <ahuang12@lenovo.com>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, linux-nvme@lists.infradead.org, 
	Jens Axboe <axboe@fb.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>, bugzilla-daemon@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Feb 2025 at 06:12, Christoph Hellwig wrote:
>
> On Sun, Feb 02, 2025 at 08:32:31AM +0000, Bruno Gravato wrote:
> > In my tests I was using real data: a backup of my files.
> >
> > On one such test I copied over 300K files, variables sizes and types
> > totalling about 60GB. A bit over 20 files got corrupted.
> > I tried copying the files over the network (ethernet) using rsync/ssh.
> > I also tried restoring the files using restic (over ssh as well). And
> > I also tried copying the files locally from a SATA disk. In all cases
> > I got similar results with some files being corrupted.
> > The destination nvme disk was using btrfs and running btrfs scrub
> > after the copy detects quite a few checksum errors.
>
> So you used various different data sources, and the desintation was
> always the nvme device in the suspect slot.
>

Yes, regardless of the data source, the destination was always a
single nvme disk on the main M.2 nvme slot, with the secondary M.2
nvme slot empty.
I tried 3 different disks (WD, Crucial and Solidigm) with similar results.
If I put any of those disks on the secondary M.2 slot (with the main
slot empty) the problem doesn't occur.
The one that intrigues me most is if I put 2 nvme disks in, occupying
both M.2 slots, the problem doesn't occur either.
The secondary slot must be empty for the issue to happen.

I didn't try using the main M.2 slot as source instead of target, to
see if the problem also occurs on reading as well.
I could try that if you think it's worth testing.


> > I analyzed some of those corrupted files and one of them happened to
> > be a text file (linux kernel source code).
> > A big portion of the text was replaced with text from another file in
> > the same directory (being text made it easy to find where it came
> > from).
> > So this was a contiguous block of text that was overwritten with a
> > contiguous block of text from another file.
> > If I remember correctly the other file was not corrupted (so the
> > blocks weren't swapped). It looked like a certain block of text was
> > written twice: on the correct file and on another file in the same
> > directory.
>
> That's a very interesting pattern.
>
> > I also got some jpeg images corrupted. I was able to open and view
> > (partially) those images and it looked like a portion of the image was
> > repeated in a different part of it), so blocks of the same file were
> > probably duplicated and overwritten within itself.
> >
> > The blocks being overwritten seemed to be different sizes on different files.
>
> This does sound like a fairly common pattern due to SSD FTL issues,
> but I still don't want to rule out swiotlb, which due to the bucketing
> could maybe also lead to these, but I can't really see how.  But the
> fact that the affected systems seem to be using swiotlb despite no
> good reason for them to do so still leaves me puzzled.
>
