Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C418E63CA
	for <iommu@lists.linux.dev>; Mon, 21 Nov 2022 15:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1669044653; bh=rn+hAhSqgQJipwQwxqVBqKqxorSbPTihZfTG+u5ynMU=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=hVAwDh0SMFDAEoAmzjRi8oZBzW4S+GMGiuLbvvcpnsa5zr0gkaPS1y5L/NCF1ORrA
	 BuUAmPSPz6Z9YoubTRWp9A1YJL7nliCacHl7QUnaB1hdz/hOFDyZHmJIe+yQVLm7Ye
	 80zP/AwAWKY/bXXrXVovTJzqDShY/P9rMrgI4Mgz4+vIXFHFCJwbKYPpTdhgZG5LSr
	 xkekM3RLoCZzOHO+0K4d2EtaI7NmEyv4m5gTqhH0u3xLw+jADN8Uy1pOMUrQKBapHX
	 x0CcFjnNc848waDiZ6kS9LNSFE0AmcUMV+gYU9HmWejx6Uph1/BOmTIWfOEoSKL44G
	 WeZKAOczNNl1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.168.19]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8obG-1p22ot20CU-015sAE; Mon, 21
 Nov 2022 16:30:53 +0100
Message-ID: <b8371d89-11fc-a170-2c3e-119197913188@gmx.de>
Date: Mon, 21 Nov 2022 16:30:52 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: RFC: switch to use the generic remapping dma-allocator
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
To: Christoph Hellwig <hch@lst.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-parisc@vger.kernel.org, iommu@lists.linux.dev
References: <20221121131623.228727-1-hch@lst.de>
 <fe7d7c8b-ac23-6025-fd7d-12f22b174220@gmx.de>
In-Reply-To: <fe7d7c8b-ac23-6025-fd7d-12f22b174220@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C6xp1AkoNPwkWvQOqVRULAqWqmZXXclM6HfFkqY1ejggcehhada
 QAuKb9AcIBOBV2ovZ5tUjzmI0+JJiXIZGHYqZXcJauYDysG4z7WCFY4ZWiwFS4N4zSgiAnB
 BGn1Y480mEI+iHpGDN1MQHlqgMVdcCxsmu3V15SGdhX9R3/MWgu5uoEkhegHlF84iI3X3pC
 rkSlPTRFLnJO5hi/57PVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:stazjEGXQxk=;o4K9k/Adco6wrl0FxCim0/bQ1N3
 LRAA4idmj37SHhVbBlICK5hyTIZADJGlSp5P6aZj5PpsAU9SE+U2PrQIEZK2DBy6JaL7EFsfP
 bTozJbJ2wvwq3V5kTS7ObhhLjb2Eqfxb+oOqfsMZhowIkOyTLSgwwm/Nqgr/7BVX0xtVPb8Gt
 avy6n4hFGGU7B3aThd1QdtKd/ZICHVhxGce90Rp5lCunSXPdPeSGm7BtpeQabZw4sjD5WEten
 c8zyOTtp+0WMLUQg+V8QCIybJMvF94MF0Nj4g1LqUvsaEQ4cFPJCf3tbuY9sDbpXNrHoPyHBz
 jcZxF42xZbYy9BOK3fUWxzXo/n8rdGMf+2xYve4MwZlFUHiPMuLx5rjjszF901of9bDWoEjtP
 inv5kJcDykulDIIO4bTRj0CoUiZ80n2E1ngpwUfoBxVuCV1nqY/S8Hm1BfNN0KXOVQeJa+n+E
 h23YOvnRhiNlv6sCr7uPyWCwUlPCArWmP17LLyp5/wteSVF0LCp1y9aU00bXXtN3RWd/vleMs
 fYGvpt991p/1SQHR82u02mEGhZmBCbyHLxMTLhpvSZJOsllYGlA4plTU+VG8FCXYn/H6xMOAO
 w4Ab0AD5VhwhUjyEhmhQIKkHnbA9c/vsr9vlkuEstGty7w0NLQ3obRx9WzBn2TDiA3aIM9FWP
 WvpFjsJbMDKKSPw3yVbLe4ISxCtpyAJBDuCJNZ4tUd0Aq9gVGBe1G+qWi4i8kNHujR2e6RIv1
 3hg+CX/+pq+Iugd7imKv9QIbtKQimGgmR8UojBBQUDPpLgPEhkP0SryvBEXHr3GKqnxiZ7Pa9
 aWTMXv1+1iA07//2qWa8VpXWGMDBqguq5pcON871+PvqaNsdbBBqUH5BiDeXQtV8QFd/FJhX/
 RmidxRwHr+/NO8mT5eZk6elFyWQ4YnBfq4p4beC2LcvjXxNgcvJPeTk6DPBsL7zSXj5gWO3vj
 fGPj1Q==

On 11/21/22 15:22, Helge Deller wrote:
> On 11/21/22 14:16, Christoph Hellwig wrote:
>> currently parisc has it's own implementation of the dma-coherent
>> allocator that sets up PTEs with the uncached bit.=C2=A0 I can't see an=
y
>> reason why using vmap to do the same kind of setup shouldn't work.
>> This small series shows how that could work, but due to a lack of
>> actual parisc hardware it is compile tested only and not only needs
>> a careful review but also actual testing on hardware.
>
> Very interesting!
> I'll give it a spin on real hardware and will come back with the results=
...

kernel builds & boots with those patches.
SCSI drives are detected, but SCSI communication fails afterwards:

[   13.509173] zalon_probe: Zalon version 1, IRQ 68
[   13.564410] ncr53c720-0: rev 0xf irq 68
[   13.614207] ncr53c720-0: ID 7, Fast-10, Parity Checking, Differential
[   13.696785] scsi host0: ncr53c8xx-3.4.3g
[   17.575885] scsi 0:0:6:0: Direct-Access     SEAGATE  ST32171W         H=
P03 PQ: 0 ANSI: 2
[   17.673111] scsi target0:0:6: Beginning Domain Validation
[   17.742479] scsi target0:0:6: asynchronous
[   17.806301] scsi target0:0:6: wide asynchronous
[   17.871736] scsi target0:0:6: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, o=
ffset 8)
[   17.965723] scsi target0:0:6: Domain Validation skipping write tests
[   18.041560] scsi target0:0:6: Ending Domain Validation
[   20.448322] 53c700: Version 2.8 By James.Bottomley@HansenPartnership.co=
m
[   20.528403] scsi1: 53c710 rev 2
[   21.567995] scsi host1: LASI SCSI 53c700
[   21.936685] scsi 1:0:1:0: CD-ROM            PHILIPS  PCA80SC          V=
3-0 PQ: 0 ANSI: 2
[   22.033927] scsi target1:0:1: Beginning Domain Validation
[   22.100102] scsi target1:0:1: asynchronous
[   22.161326] scsi target1:0:1: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset=
 8)
[   22.250962] scsi target1:0:1: Domain Validation skipping write tests
[   22.326829] scsi target1:0:1: Ending Domain Validation
[   23.972351] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[   24.052265] sd 0:0:6:0: Power-on or device reset occurred
[   24.117020] sr 1:0:1:0: Power-on or device reset occurred
[   24.185309] sd 0:0:6:0: [sda] 4194685 512-byte logical blocks: (2.15 GB=
/2.00 GiB)
[   24.279279] sd 0:0:6:0: [sda] Write Protect is off
[   24.336921] sr 1:0:1:0: [sr0] scsi-1 drive
[   24.386003] cdrom: Uniform CD-ROM driver Revision: 3.20
[   24.451015] sd 0:0:6:0: [sda] Write cache: disabled, read cache: enable=
d, supports DPO and FUA
[   24.569057] sd 0:0:6:0: Attached scsi generic sg0 type 0
[   24.634080] sr 1:0:1:0: Attached scsi generic sg1 type 5
...
[   28.246342] EXT4-fs (sda5): mounting ext3 file system using the ext4 su=
bsystem
[   28.338790] ncr53c720-0:6: ERROR (81:0) (0-0-0) (8/1b) @ (mem 43c:00000=
000).
[   28.343500] ncr53c720-0: regdump:
[   28.343500]  da
[   28.343500]  10
[   28.343500]  c0
[   28.343500]  1b
[   28.343500]  47
[   28.343500]  08
[   28.343500]  06
[   28.343500]  07
[   28.343500]  45
[   28.343500]  08
[   28.343500]  86
[   28.343500]  af
[   28.343500]  80
[   28.343500]  00
[   28.343500]  07
[   28.343500]  0b
[   28.343500] .

Helge
