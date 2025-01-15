Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC098248BB2;
	Wed, 15 Jan 2025 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938065; cv=none; b=QA+kS91JaaxgiGV1d4Ta8OFyV1eQ/ML7ZkNsmLz8eiVYUSSIfHQmySfyK2jWJqY4RMpSECNOjCl2ADn4ndvabs/PPxzCQGHEHOnR/2ygEEq8DCAqKsrAxmGLNndo9RfXRlN4qC5xZ4OxI+cxlk8jnhhvNq347UucGZ6z4KThbII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938065; c=relaxed/simple;
	bh=Rx3oLYOkICxXiyHNFPEHconfqfrkEoxKVgFfoVuQoyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlHq7peaCivVkvLbeECPp+tJpXSYN9qP2ZcHWteMGtq3xvgh3sg9FZfFfylyb2P/QY8hvRys6WwrPAzX/XSYsHQU5iW9GTtAt/h+dGa2YCrqqP23f3bTMDdZJFHAgdlX6SfAuFG3cp5+u6Nc3xkVjdioc6ixI54E+f2fbZolDug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simg.de; spf=pass smtp.mailfrom=simg.de; dkim=pass (2048-bit key) header.d=simg.de header.i=linux-kernel@simg.de header.b=1SVU+6g1; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simg.de header.i=linux-kernel@simg.de header.b="1SVU+6g1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simg.de;
	s=s1-ionos; t=1736938050; x=1737542850; i=linux-kernel@simg.de;
	bh=+fZuuelokoOKIA//FmKWAdBZjtvQ6Y+FnIu++jUy0fQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=1SVU+6g1ketCcYvZHtKmJ6m/LYY+YtfhYWFTWGGqnHRKrolCMxGjLRqmXsIu+uWM
	 tF+x/QojRJsbM2aHlGFV49357rLhe8Cp9clLkT9vJZEpLvjFkcFp0RFxYFWQfPFI4
	 NacsNJe3sdwmTvM2qPHoS+qJ9K1rQKzVozaVEhLhIb0qRahG89DiRYDmsbBy6SKKW
	 2JJf+c99G/dqn7Qmv9Ku1W04S2yRM+ezH//Wx24+n4dajDcoVif0OXRwt4+D66lTP
	 S9ZyiAXghslH3t8nIR20zHRBNBks6IUEbOZ3J7xvVJR9nCB/Iz/i9LLP65le9hP5s
	 y/fm9TlcWjN9zKrdAg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.1.60] ([93.217.99.181]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MqZE0-1tBtbd46qW-00a8Lv; Wed, 15 Jan 2025 11:47:30 +0100
Message-ID: <6c2a34ac-d158-4109-a166-e6d06cafa360@simg.de>
Date: Wed, 15 Jan 2025 11:47:28 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Bruno Gravato <bgravato@gmail.com>, bugzilla-daemon@kernel.org
Cc: Keith Busch <kbusch@kernel.org>, bugzilla-daemon@kernel.org,
 Adrian Huang <ahuang12@lenovo.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>, Christoph Hellwig <hch@lst.de>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info>
 <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
 <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
Content-Language: en-US
From: Stefan <linux-kernel@simg.de>
In-Reply-To: <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rnFdIXYz4Y9QPkpV/BUfkHAd3Td8QA5l4h8Y3z5YvImjTAdXNdD
 p0nu2ylUaMNi1dpXaWVWprQ+d9OqgyCeEMl8diDJI/Um8xAQgVTyJhZPttsJ19JWpBiF4oe
 rsrtuAVEyHKriBeuqEnybp+oLtgLJ/NkgTn3R2mqZ1ePv74bS/VYRjiIzwNz669EoanOgFD
 FT4v5HV/BDxonfWYOncTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kt1B4uIbJec=;O4TaXg9JowgzvJ4zJRqEt3csfIT
 09oa/FZ8omDf5Px+BrWTF/3oC/vWV6IslnxB0ZdGRWg42A9150y/dnP8UPyYGUUMXLGoC5eIU
 +JO0dMue8SJJOL/mSdsqjFV9LYgTe1s/0PddMGnd3mrIBlnxJAFrLp9iFFh/QcGckChSHGhtW
 f6sdysf5/0H2E9tB1oDJDaea+Uiq3fPPKr+E+RT17dzrsNGFyoOTuuNmW/Y366FDt4mUK2dcC
 RjJN3GB9wrimlVguJoBZyzKsrL83nkgImF4HLCrGfZfB2hbTDjaw3kcetgns6odoHFDtKl21K
 FYNZC80owE1fBA+dFm4ebeVAwGCpmbhyiXtFACK432A6agVKGv+FYWzhVZgLVfTg0bFnXQ/ih
 VFduENFOSsqxWNOyxiwkNwEldlfEEhlvNjwf0SspP4Sv58X53AYwVACCxGnQTVunxc5w8czuY
 5+2cUAv6l16CXuqd/6tAEn8OV4KM593DcPiWgsurdfTvPpONrmsVdbGQtZo1/dBJcouNnBH/x
 YpACii1etD7w2KRq5+G2die7jKix1JOjzusXI3BRWc47Ezgm9phAIlcQ++veY1dh9FYfTI2ZK
 xqaqBwZskOgKp5ng/PA4csKJS819OKvfFZCWhU7xrhmmxjKNF/BXDOm406KuirZiSvVeE1KQg
 8g+Jvw6OBhOKYZ2fehf+u1ZHprYAS1ZMBuJ6MTbMykvXctNor1683ZGe1piP+r75aLnKVDKyQ
 iuP4w1vvyc6SgcdVrEJdmkWk6Kpn6vywYNVQ1vbW/6IQh/C6jxCX9aJsxZJqTVYkt8t02ABlM
 VlY7Ta9xwCKxJw5zmIRyiTHFQR5PnXDkYYDw6l6P3KtfcccsedFfRkVyJssr6Wf5kS6HQEct+
 2BIGUt4KOm0Z4xRb9vxmtce64c1XuWuyzdmgH3711DciKZTygqJLlfPNDjow4vI+EYPjZxzDv
 Kc95LxWs1hb4M/Yl+TdLUlCh4lERPW7hdEkSxFyrXUs+ZiFB/6joPIPpY6G14zLwcL61o/Cdv
 0dVEgIuZLl+79w6ULzIjOZiN5+wMEzqpkiagG2mOHnimaAIyKWlt3bVYkJA4FaCl6nzykNsDE
 3HiPB8xgw=

Hi,

(replying to both, the mailing list and the kernel bug tracker)

Am 15.01.25 um 07:37 schrieb Bruno Gravato:
> I then removed the Solidigm disk from the secondary and kept the WD
> disk in the main M.2 slot. Rerun my tests (on kernel 6.11.5) and
> bang! btrfs scrub now detected quite a few checksum errors!
>
> I then tried disabling volatile write cache with "nvme set-feature
> /dev/nvme0 -f 6 -v 0" "nvme get-feature /dev/nvme0 -f 6" confirmed it
> was disabled, but /sys/block/nvme0n1/queue/fua still showed 1... Was
> that supposed to turn into 0?

You can check this using `nvme get-feature /dev/nvme0n1 -f 6`

> So it looks like the corruption only happens if only the main M.2
> slot is occupied and the secondary M.2 slot is free. With two nvme
> disks (one on each M.2 slot), there were no errors at all.
>
> Stefan, did you ever try running your tests with 2 nvme disks
> installed on both slots? Or did you use only one slot at a time?

No, I only tested these configurations:

1. 1st M.2: Lexar;    2nd M.2: empty
    (Easy to reproduce write errors)
2. 1st M.2: Kingsten; 2nd M.2: Lexar
    (Difficult to reproduce read errors with 6.1 Kernel, but no issues
    with a newer ones within several month of intense use)

I'll swap the SSD's soon. Then I will also test other configurations and
will try out a third SSD. If I get corruption with other SSD's, I will
check which modifications help.

Note that I need both SSD's (configuration 2) in about one week and
cannot change this for about 3 months (already announced this in December)=
.

Thus, if there are things I shall test with configuration 1, please
inform me quickly.

Just as remainder (for those who did not read the two bug trackers):
I tested with `f3` (a utility used to detect scam disks) on ext4.
`f3` reports overwritten sectors. In configuration 1 this are write
errors (appear if I read again).

(If no other SSD-intense jobs are running), the corruption do not occur
in the last files, and I never noticed file system corruptions, only
file contents is corrupt. (This is probably luck, but also has something
to do with the journal and the time when file system information are
written.)


Am 13.01.25 um 22:01 schrieb bugzilla-daemon@kernel.org:
 > https://bugzilla.kernel.org/show_bug.cgi?id=3D219609
 >
 > --- Comment #21 from mbe ---
 > Hi,
 >
 > I did some more tests. At first I retrieved the following values
under debian
 >
 >> Debian 12, Kernel 6.1.119, no corruption
 >> cat /sys/class/block/nvme0n1/queue/max_hw_sectors_kb
 >> 2048
 >>
 >> cat /sys/class/block/nvme0n1/queue/max_sectors_kb
 >> 1280
 >>
 >> cat /sys/class/block/nvme0n1/queue/max_segments
 >> 127
 >>
 >> cat /sys/class/block/nvme0n1/queue/max_segment_size
 >> 4294967295
 >
 > To achieve the same values on Kernel 6.11.0-13, I had to make the
following
 > changes to drivers/nvme/host/pci.c
 >
 >> --- pci.c.org 2024-09-15 16:57:56.000000000 +0200
 >> +++ pci.c     2025-01-13 21:18:54.475903619 +0100
 >> @@ -41,8 +41,8 @@
 >>    * These can be higher, but we need to ensure that any command doesn=
't
 >>    * require an sg allocation that needs more than a page of data.
 >>    */
 >> -#define NVME_MAX_KB_SZ       8192
 >> -#define NVME_MAX_SEGS        128
 >> +#define NVME_MAX_KB_SZ       4096
 >> +#define NVME_MAX_SEGS        127
 >>   #define NVME_MAX_NR_ALLOCATIONS      5
 >>
 >>   static int use_threaded_interrupts;
 >> @@ -3048,8 +3048,8 @@
 >>         * Limit the max command size to prevent iod->sg allocations
going
 >>         * over a single page.
 >>         */
 >> -     dev->ctrl.max_hw_sectors =3D min_t(u32,
 >> -             NVME_MAX_KB_SZ << 1, dma_opt_mapping_size(&pdev->dev)
 >> 9);
 >> +     //dev->ctrl.max_hw_sectors =3D min_t(u32,
 >> +     //      NVME_MAX_KB_SZ << 1, dma_opt_mapping_size(&pdev->dev)
 >> 9);
 >>        dev->ctrl.max_segments =3D NVME_MAX_SEGS;
 >>
 >>        /*
 >
 > So basically, dev->ctl.max_hw_sectors stays zero, so that in core.c
it is set
 > to the value of nvme_mps_to_sectors(ctrl, id->mdts)  (=3D> 4096 in my c=
ase)
This has the same effect as setting it to `dma_max_mapping_size(...)`

 >> if (id->mdts)
 >>    max_hw_sectors =3D nvme_mps_to_sectors(ctrl, id->mdts);
 >> else
 >>    max_hw_sectors =3D UINT_MAX;
 >> ctrl->max_hw_sectors =3D
 >>    min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
 >
 > But that alone was not enough:
 > Tests with ctrl->max_hw_sectors=3D4096 and NVME_MAX_SEGS =3D 128 still
resulted in
 > corruptions.
 > They only went away after reverting this value back to 127 (the value
from
 > kernel 6.1).

That change was introduced in 6.3-rc1 using a patch "nvme-pci: place
descriptor addresses in iod" (
https://github.com/torvalds/linux/commit/7846c1b5a5db8bb8475603069df7c7af0=
34fd081
)

This patch has no effect for me, i.e. unmodified kernels work up to 6.3.6.

The patch that triggers the corruptions is the one introduced in 6.3.7
  which replaces `dma_max_mapping_size(...)` by
`dma_opt_mapping_size(...)`. If I apply this change to 6.1, the
corruptions also occur in that kernel.

Matthias, did you checked what happens is you only modify NVME_MAX_SEGS
(and leave the `dev->ctrl.max_hw_sectors =3D min_t(u32, NVME_MAX_KB_SZ <<
1, dma_opt_mapping_size(&pdev->dev) >> 9);`)

 > Additional logging to get the values of the following statements
 >> (dma_opt_mapping_size(&pdev->dev) >> 9) =3D 256
 >> (dma_max_mapping_size(&pdev->dev) >> 9) =3D 36028797018963967 [sic!]
 >
 > @Stefan, can you check which value NVME_MAX_SEGS had in your tests?
 > It also seems to have an influence.

"128", see above.

Regards Stefan
