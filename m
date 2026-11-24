Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795543707;
	b=O95zmaYALHNnqinzma7Htn50Qb7dCwngM5NVcHZhFB2N/hu2DMZB1VWhQEzYsniq1qvy
	 LYt9dQPVlNZj0rayQ8+0xdH9yt4M98j2023oW3LOC+czId5pdKx6q4jkgKSU+vU4l48o+
	 UNDDA6gNn3Soo5/6rbqSlTz1zGnzeEn1iRiDRIVgmCr5Sqof/H86a+kXL/A1e4bEJVp0s
	 IZ8XTHOcuG0xo2dt+9hX8407vSRl+i0b6xifK5hY6DSSG3DhjPn4BsSUxV1dpJrfXZA4s
	 caR+FEo9unbwjwBsbeasre9r8hUFM7uVmCjzjM8lNL42VslvJKuUrDwn6W6dRzks50w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543707;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=nMArKgXUq1QdbGtgFkpPLn7kMqNxxKYfOey9dGs4DsM=;
	b=WD6QtaweZvsd1Iv8r00HJcSQmbWV8vqNOsfzvv+RnB0E1GzPxeTop7z2axnFppeKlKLV
	 H+iuHT/+30a9UdLhZtzbW4OWormafhTejDogTSYEIUoHU01B0wBgWYv86C4/dY2w5/D+D
	 wAXC/pNyOnoXiDgDqy9vy2Fo2zBYEbNGiDyMOOB7tlxKsnZ27jOSC7hd7oBQ77Chz8BdW
	 Zt0j3yI01sqsb6DJO9dus16N6FdQhET6I5j/DoZ6ERgxERV3X9fJfVGEDtmsdVJP/TGLs
	 QI9nMHF/QX07ASPwCMlbqdWnNHx8iySIGYvjFZCaR/QbaJs5iXAzbgMvVRawldF+pTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lBzuCe2W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D371A606A334
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 18:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D371A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lBzuCe2W
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3863db981d4so6680580eec.0
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 10:08:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795543706; cv=none;
        d=google.com; s=arc-20260327;
        b=N0tNKV9BgXPKU4BKt8UGhrDtAsvghCLEDlFZHL8k6TFtd09mU4IeBotGxtjQkYmfrT
         zPgk3sMdPTMKpYMMBWw5jWkQASr2O2WLyYDZOG7fcuT5LG3nb5fXPclBkX4ENjas2viY
         68gJ3SYa494+FxVOYBfBWfC1qZzQ3zwEoo87fvaOweyJ2Ry0j6rfrBcXBsAwqhZvzeHE
         UAFmJb+VRdNKhBdLK1snJLmlE+mDITPL7UadArSSeADSnDNBMJYT8HSmRABxug4Lm4q1
         jgIMjEAkO/30YSX6oX57Lu3uGbKYJq/lE5Jnn4Q84U09WO5JQKvMwTfQObP+L0aXqFhs
         bhhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nMArKgXUq1QdbGtgFkpPLn7kMqNxxKYfOey9dGs4DsM=;
        fh=wfcUeUwVo/fYC3RmZEPUth7mcCyPmVu6f2CENSf9XmE=;
        b=LomDxil31SbB1TkEk/P6AnUI9bskCCvI3wNFfC2WFSV6WzM5hipGolDPspc0yyGBoE
         2XJD+BeeMoSqMBA0DIgNre4lE3acJeqcYwL4R8HD2g4TlfnZxmDts2Z0uR26CFHcQeqp
         qYsYKJEsgw8+PhXkr9fYQA0fHQiNWZU5kHtSexsVbbz7U78zDKVhzBAjpM/r/STqyA4b
         Y86DYbqKxjDtR1KULiYAp18ZwtWLAMh1HixzBdALs5uEirhh171QkZg8eq1n1F0cUdL4
         4BhS1TPG6nliDOpuzZ7B7My1P4Wz7cyNszjcEOvfpmYRPuGnAW7Dnapdrpncv3X0v+iB
         bJzA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795543706; x=1796148506; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nMArKgXUq1QdbGtgFkpPLn7kMqNxxKYfOey9dGs4DsM=;
        b=lBzuCe2WKlS2ixoEPa3kSlCYWS0ZmW/KM5gsPG5igZ2B/SWPnJlSjnTnYU7E+EsXmT
         8/rokma4/NgKY0bGWAh9w3+x3pvvHYcyMW1lXeLa9Bsn1TAhaTHJkyulAlSYhBTrvAUV
         xCOdihV/EAq43Ch+yZX0oIzEXHY5IRmAVQy1z4TdRPHUrbPXHCBoJngC0o6cq8bjkCmq
         zFLyaAdnGRXan7IwhRLhDedKgUWtn/Iqsz+JwnTOi2hKlurCL/GWv+iNfQ0H9rJRm6ix
         SiZKSx+9nNnfc+YGl82tap6CFFHlgeHcXce4StHQGpQWpTo6gs2ffUu5CWnfzj9vep/Z
         mxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543706; x=1796148506;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nMArKgXUq1QdbGtgFkpPLn7kMqNxxKYfOey9dGs4DsM=;
        b=VUGyY6CLmqp/CTtYHbx//wkCh1IKZ3OOHQ+DB5a1G0gke9OmzQV9uQkOXZpF0SPi4l
         oVSwVGNieH+oPLRuPWp3pIA0wOKg2BewNvD9N2E8UbOqBsPTXEOg1Fi1RjtOMovfFqCY
         YogT6RjciKf0RmF8iIGW6Y+rA+DfTeRKbDuOKffdnIm4XBgNQ6KTA7liI7hbBL4FC2mC
         xfZeghuhJI01LDo9MHnOtr93I2GWQ8JbuY7QnMLeAk7a+czHE3DoJsPL4/BXcOsGVY6i
         wzZJ0gx9wqXlQQxVE8Uxk2s1jzYBRXO5uCSFshj7pC6EXYQ2MnUHYNddyU0dqEQLhAQ5
         VLWw==
X-Gm-Message-State: APuU4Z/Xn8Rik1u95/jTAMAzi31db6gL4PvtK50p0e0chpfS3PaeZiuu
	X9tIYMBRL2C0BZBxVS208wKFPfrWi+5YOQqZGGfEWcsRiz38CnsiVP0UUvRwhqIheO4I53fmlHp
	faSnRshj1kvVsMMeV1ClcRcGBgWIiSp7Mi0TbF65GyWYl
X-Gm-Gg: AZFdTZe47qdHOBkjiv3Sj5InQ5TpwRNQN/FcHT35JOJHrZunZuK1DN28BLjxLTR5mYP
	jSY8M8ykGXmbnQ33aSPn1R+eQl/G0yft96F0dosAdxsbcG9aEgws4kWZjETHoVnugXAbZVwNGxp
	yT7ZfbKh6/nOvKKKPuMMrQ1GCvGt9ETBbl2vQJKiZVo/5YFKvZskqnRR3YokiZyIPE3kvSwqamT
	AqM+8+9Js89vIcEsvC64j6Iaw5NQl2uVbubglfzi+5s0TSv0kbxZYWojzQ8dnoZkNakGTopUfwf
	74ulPhyj8wsk+Ce46fx4cf+xWdeRgFFJ0Yy7KV3UUocIy4RIgYpH4Dbo0NhO3fhY9UUS8j3KiSu
	tboj0cGTaS7iJhbo5lojar96I5IBgFwNRJQEB
X-Received: by 2002:a05:693c:60d7:b0:386:a01f:a31e with SMTP id
 5a478bee46e88-386a01fa8a5mr11918162eec.29.1795543705646; Tue, 24 Nov 2026
 10:08:25 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: Pe3k <pe3cek@gmail.com>
Date: Tue, 24 Nov 2026 19:08:13 +0100
X-Gm-Features: Aa3M54otumHZzTyMQ-Us0DWBLs1TljAZawi1sbF3vaHvMFbTD4Mkpwm8wiJeKc4
Message-ID: <CAGvcwsDdKSZe0reeuT0eQabaSbM6+KAfwFimxiqhvKrjD2nQeg@mail.gmail.com>
Subject: iommu/vt-d: data corruption, AHCI gets IOVAs inside its RMRR (HP Gen8)
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On the HP ProLiant MicroServer Gen8 (Xeon E3-1265L V2, C204, BIOS J06
04/04/2019) the AHCI controller is handed IOVAs inside an RMRR that the
firmware declares for it. With the default translated DMA domain this
corrupts disk data on every boot under write load. iommu=pt avoids it.
Seen on two machines of this model, on 6.12.118, 7.3.4 and 7.4-rc4.

Topology
--------
00:1f.0 ISA bridge [8086:1c54] and 00:1f.2 AHCI [8086:1c02] share IOMMU
group 10 (DMA-FQ), probed in that order. The group's reserved_regions
include "0xf1f7e000 0xf1f94fff direct". The DMAR RMRRs covering that
range list 00:1f.2 in their device scope, but not 00:1f.0.

6.12.118 (default cmdline)
--------------------------
Once per boot, ~20 min into sustained writes, 23 errors (21 + 2):

  DMAR: ERROR: DMA PTE for vPFN 0xf1f80 already set (to f1f80003 not 167119001)

from AHCI writeback (ata_qc_issue -> iommu_dma_map_sg). Each one is a
4 KiB page that reaches the disk with wrong content: mostly zeros, some
with firmware data from the RMRR. No I/O error is reported.

7.3.4 and 7.4-rc4 (default cmdline)
-----------------------------------
No DMAR errors. Instead 64-84 writes per boot fail before reaching the
device:

  ata2.00: failed command: WRITE FPDMA QUEUED
  ... res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x40 (internal error)

followed by I/O errors and 4-8 MiB of zeros in written files. In one
7.3.4 run the machine also took an NMI (iLO: "Unrecoverable System
Error (NMI)"). An iommu:map trace filtered to the RMRR shows the cause:

  map: IOMMU: iova=0x00000000f1f7e000 - 0x00000000f1f7e000
paddr=0x00000001c94d6000 size=0
   => iommu_map_nosync <= iommu_map_sg <= iommu_dma_map_sg
   <= dma_map_sg_attrs <= ata_qc_issue

With iommu=pt both 6.12 and 7.3.4 run clean.

Suspected cause (not verified in the source)
--------------------------------------------
The domain's IOVA reservations seem to come from the device that
initialises it (00:1f.0, no RMRR). When 00:1f.2 joins the domain, its
RMRRs are identity-mapped but never reserved in the IOVA allocator.

Reproducer
----------
Fresh boot, ext4 on an AHCI disk, 6 parallel cp of a 10 GiB random
file, sync, drop_caches, compare hashes. Fails within ~25 minutes.

I can test patches on a spare machine of this model. Full logs, the
DMAR table and traces are available on request.

I used Claude Code to run the tests, analyse the
logs and draft this report. The results and logs are from my own
machines, and I have reviewed the report.

Thanks,
Peter Nouza
