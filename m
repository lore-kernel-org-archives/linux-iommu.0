Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5D81A6827
	for <iommu@lists.linux.dev>; Sun,  5 Apr 2026 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775409256; cv=none; b=ejtTsScSmvnllRiw2MrL86d5otZ9QeWfzFkh7h+H/ScLVr47MYL9HZM9Q+iVqNUBySoULmkV9zPA8+5gNdcL7hCuIsF1rXbqeIwuhGx3DR6PPMqggeU20BVxIVHC3+yYnzaSOmMp8R/S8274M1hayPGqVLwC2UUlOnoipv5+iHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775409256; c=relaxed/simple;
	bh=ickk9stNWfzyjItZXZmszlry0c85KKxJeR9bJjjYIWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCb80l16PXS8tdX3nGXnMLDiB8z7YGYAPjmPZpLB7XKPLfAllDm60oCYQte0wCqdEJBG7qQ+pnbF8mQgNxcDTlqlkeEV1tAA2h/vwiPBM3yhEAbbGNr0NyAsGJy+qppsV9j5zQKWTtf+/acM8n8T8iOEI6TAHsNlm5+LgNMNxAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=PHQgwaX7; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="PHQgwaX7"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4fpfFZ0T8Hz48Sr;
	Sun,  5 Apr 2026 19:14:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1775409250;
	bh=ickk9stNWfzyjItZXZmszlry0c85KKxJeR9bJjjYIWM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PHQgwaX7IVQulbZLqHMdo3eQTZrmz1WTgD9dUMRoTpQ1BedPXxYxYYBxMux+9bYvP
	 XgrAJyd62lzUDPaO80PrJaX3duhjCKtJpl5FkUAdLErG/P4h/DhF1Jou62mzzFPtE1
	 ajNalyXqcBSZYnXFNBSP2oTCyTN3O5fYkevm8dkKkn0g+mwE8giOm3scllvyGzm2dI
	 HdU7hSMxqsrmb64yPCzGTqqJG5sUZjkMEVv20u1q8V/Qt+HiJvQnslEqew31jBo+iP
	 ZhsjCdEhXBiHSm1l0wI5m89efPfYu2qUkPc+uEF5CluP5LaPZBXbh3a4sksQb2p4f/
	 8xRUotOctHpNw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4fpfFY6sBTz7vxv;
	Sun,  5 Apr 2026 19:14:09 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fpfFX6zLzz8sbB;
	Sun,  5 Apr 2026 19:14:08 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id BFA5363623;
	Sun,  5 Apr 2026 19:14:07 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <ec71ed01-1ec1-4e3d-9724-a51db8e10c0a@leemhuis.info>
Date: Sun, 5 Apr 2026 19:14:06 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re[PATCH v1] iommu: Skip mapping at address 0x0 if it already
 exists
To: Elisabetta Bruno <artisticdesign@gmail.com>,
 "lkml@antheas.dev" <lkml@antheas.dev>
Cc: "Mario.Limonciello@amd.com" <Mario.Limonciello@amd.com>,
 "alejandro.j.jimenez@oracle.com" <alejandro.j.jimenez@oracle.com>,
 "dnaim@cachyos.org" <dnaim@cachyos.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "jgg@ziepe.ca"
 <jgg@ziepe.ca>, "joro@8bytes.org" <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "will@kernel.org" <will@kernel.org>
References: 
 <CADvBJZm8nqbpNRvB=WheP6QhWDXMbtcKff3R7F93Ffy5NBOUWQ@mail.gmail.com>
 <CADvBJZmWHUX_3mtFBU8AQ_C12Os3TSRYD0jjRb2p2755-qne6Q@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CADvBJZmWHUX_3mtFBU8AQ_C12Os3TSRYD0jjRb2p2755-qne6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177540924826.3271312.4383753797160457047@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: BFA5363623
X-NC-CID: dSW+cq0r+ktfBIimskFpRDuOsv1PUjDyxhrD1klans+mfPiH4UY=

On 4/5/26 17:02, Elisabetta Bruno wrote:
> On Sun, 22 Feb 2026 00:50:50 +0100 Antheas Kapenekakis <lkml@antheas.dev> wrote:
>> Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
>> introduces the shared iommu page table for AMD IOMMU. Some bioses
>> contain an identity mapping for address 0x0, which is not parsed
>> properly (e.g., certain Strix Halo devices). This causes the DMA
>> components of the device to fail to initialize (e.g., the NVMe SSD
>> controller), leading to a failed post.
> [...]
>> Closes: https://www.reddit.com/r/cachyos/comments/1r5sgr6/
>> freeze_on_boot_after_kernel_update_to_619_fixed/
>> Fixes: 789a5913b29c ("iommu/amd: Use the generic iommu page table")
>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> 
> As I am seeing this still marked as pending fix, hopefully some real
> world testing might help.

I lost track here, but from a quick look I suspect 0a4d00e2e99a39
("iommu: Fix mapping check for 0x0 to avoid re-mapping it") [v7.0-rc5,
v6.19.10] fixed this;
https://lore.kernel.org/all/20260227080638.208693-1-lkml@antheas.dev/
and the links there have more details.

And if I'm wrong, please yell!

Ciao, Thorsten
