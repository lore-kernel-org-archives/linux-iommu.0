Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212EE391517;
	Wed, 13 May 2026 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655059; cv=none; b=sC7GN9fYIK9iXjZFido3bTL0VF8S4CMb+5mDzy3sPcLFh0Ph6Qhj48TKhdavD+Pz6uAOjkOk8VLBZdsgTRMZ6pCrNbUFu4OP93Uz3MzMX2PwociFIHNhSGTE2bfbL/MI7Im43ppN2mFfb9Khgv6nxUs+/c6Ob3txunGEwUF6VLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655059; c=relaxed/simple;
	bh=lTDwtGysRq7hkS0Y7aGitl6TT3RUqPXqifYMKOQ3eg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4+HrvRCoJoiR3whum/K7fNjrIsxmOwFHKjWVHtImnO6K2xVtbbIdkE/wR6O9zGf43f32cUe1xOh15SyS0LsEqMQxF5a1t2TisVI9AV5B3l+CRpPWPqtM2+7u/O+QDxmjXM1dUhZe7SL/Bjvx2cdx+0G12TyIz4uzcu0h7mpKOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=XWNgHdNb; arc=none smtp.client-ip=188.68.63.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="XWNgHdNb"
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4gFkcm1WMLz6DMP;
	Wed, 13 May 2026 08:50:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778655048;
	bh=lTDwtGysRq7hkS0Y7aGitl6TT3RUqPXqifYMKOQ3eg4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XWNgHdNbT8uQ0+OXW1SrsQ362+PJ5nlh5PEa4oI+GD+BLJCo//74HA2pxSCRAjK6/
	 fo6RdQI7wEtpsinJfOB8Fq39BSgEPoJO1Qga2sk4C28o0splZk9Exq/f5bDrIhPZFF
	 yV5h+4m/EGYqVzdeyViOXZJyx8NJlRmUIPTlDtuThthOpuEqdrS5Lxstdkenvzg1AY
	 GmiU0Z4Pv8KqshRWvwMg0fPA0NRO58ipqbAvuFR0oVI07LZC4yhSjinb9jZjDe4+C5
	 d7eKjKGsNTUBbKsCRJRelQ7ySqkaB06aQ5fbxCaKA1nqTYQda3VfhHBVU8R064xp1L
	 wmA6gkbsCpuMw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4gFkcm0kg6z4xvt;
	Wed, 13 May 2026 08:50:48 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gFkcl300Hz8sch;
	Wed, 13 May 2026 08:50:47 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 79E3B60305;
	Wed, 13 May 2026 08:50:46 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <a2a3fecb-5b9e-4574-bd23-fe7e0ce14bfa@leemhuis.info>
Date: Wed, 13 May 2026 08:50:45 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] GPU passes into VM improperly after c376a3456d8b or
 a98db518dde2
To: 70sp <70sp@protonmail.com>, Baolu Lu <baolu.lu@linux.intel.com>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: 
 <z7Rkts0EsooZcnCjNfJaK6ursftFU8ubOkH0hcNjzxugEAwGsHLMblOdfoAx-gJzBZ-TMmeUtD7iWBngbFY5UCJCwdSmYqmCVMy-yhbirUk=@protonmail.com>
 <56ce85d5-e0b9-407c-9a86-708111a8a509@linux.intel.com>
 <C4BK-Bp_FII0EkxSHQxBS2wO-Age-UxFrp_KfmYzb8cnQ8ZndzBBIPD8S9T86wOifBP0tysQGCFtGQsBsBvG2IzIMw3jb3NF5HGbS3tsawA=@protonmail.com>
 <d6a7f70c-5a8a-4be6-abdd-5b3decbb602a@linux.intel.com>
 <uaUIyysjsnLHVLladjVXkuU63CTRoEzcw3BdlDX2cdkt8T82i0AX79VQAJo08uMKvpnn20xyK0Pu2PrtyMV3hmSgcwutWhV14fgjyTW3aiQ=@protonmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <uaUIyysjsnLHVLladjVXkuU63CTRoEzcw3BdlDX2cdkt8T82i0AX79VQAJo08uMKvpnn20xyK0Pu2PrtyMV3hmSgcwutWhV14fgjyTW3aiQ=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177865504675.1976311.7887495488887018125@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 79E3B60305
X-NC-CID: OC9jNeE25qOyWQ8qzWOwPFA2h/g5tnaGARNRJA+duQgKG9F5xG8=

On 4/29/26 22:30, 70sp wrote:
> So I have tested it on both a working kernel (v6.12) and an affected kernel (mainline).
>  
> I managed to get the domain translation structures on the affected kernel, but couldn't get them on the working one since reading the file always ended up in a system crash or a segmentation fault.
>  
> I also couldn't get the PASID table entries, because the GPU doesn't support PASID.
>  
> Domain translation structures:
> GPU: https://pastebin.com/4EY5Wmsj
> GPU audio device: https://pastebin.com/fLf7weii
>  
> I've also looked through dmesg on both configurations, and on the affected kernel, this was the only data I found to have atleast something different. (On the working kernel basically nothing was reported)
>  
> Referenced snippet of dmesg: https://pastebin.com/5e3jQ2BL

Lo! Baolu, just wondering: what happened to this? It seems things
stalled. Or was there any progress to fix the regression that I missed?
Or do you need more data from 70sp? Ciao, Thorsten


