Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649265;
	b=fSEY4Br9ch3sH6a1kQYysYfQuVYp2nuLdvE1BJXlyHWV+Qsvk1B8uUiACWPXZAcmGxSS
	 KXh01Bi4Dq3UB3T1wrAQ1DD7dS4z4t0gLwyI1LKTEOopYO+eP0vz34KSMNUZNC4blGWhy
	 WfItq18x8Y72bK7JDyXcgW0rEiSu3J11NS/mYLtbiCD8n0ECEWgfrD/TPDBlIZmxa5QqY
	 oXojarUloEX5blGgEdOjtfJWoZXJyMT4xD18B2Bd6SzY0MU8F9ZaHCexT6RW0qw+sxcQJ
	 1gJxIfeIVoZmQOqbVh84nfu/lf6kTk9wc8UThGrewXCV9kQOLU5dl+vOpNZemsO1XWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pzjyGmZZ2mfKFwIvgz7xu0SROw+6FToALTMc9Gn5dzg=;
	b=EE7djKqVv5JHDg8zoEGrKpK3kM2atWNmAlHJWRZyTUpvDQAW3YucxZ3bNaJuWY5k502h
	 ja5yxjdjY/sPg9ZWXT+zWjusG2fv4zkXFDc9Q043fPFVVIwtvKPpICxhnrcogez21JUsl
	 0ybrGat88iZneRnoAlpn1bPsaB1LUcfIUy+Q28tSMOjYed6ITmmgybYetutUF43I59kID
	 oJ5EsWAl9Qf8AXvREI2A6vNG20MRnsiOsuorhRQFGWrZpP7hxa2MylaVoxJ3MP+zytj+Z
	 Jrh8dM/DO8Ho+u0QW3VI34z4IcvoftqS41kNU4Mm1UDxR6eJlPjmAe1KQrnLmbKb0ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=gPnllvaQ;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A22606A321;
	Wed, 25 Nov 2026 23:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12A22606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=gPnllvaQ
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jZbSV44Hqz1XM6JG;
	Wed, 25 Nov 2026 23:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1795649253; x=1798241254; bh=pzjyGmZZ2mfKFwIvgz7xu0SR
	Ow+6FToALTMc9Gn5dzg=; b=gPnllvaQem7qSZpDqnmOE63QftMGzquLwF+QaY0r
	salGmSB2zP8C/wjUkmk6DFKVDjz2trunYUOpMkrgsAEMhAfJgLTOZLqW2ZuDidm0
	uRzqw4+VtN+EYunO+uTw3T84mP9EWsNnlJQNbjyyOQ4fS/kAosySDxGBf87E313b
	4wx+K/0Xr1llkEqP6a7XixWcSCpyZnHl+qrPRoP+v+9ncgxkkEh4MxIrLUSOECnC
	HKN36CKV4FVyohOtrhUBO7vmxCo8nL+e8cgLdW3KMWjC8tSOfC7YpiTkSCGrHLD0
	X0YtJcHbdF7QykvG17dJaBTad7msKVCfhnS9x8RuIBcWHA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WpI1dKdOLk4G; Wed, 25 Nov 2026 23:27:33 +0000 (UTC)
Received: from [192.168.0.215] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jZbSN73yTz1XM30h;
	Wed, 25 Nov 2026 23:27:32 +0000 (UTC)
Message-ID: <0edb9525-5068-42e6-b6c3-a1dcebcbcea7@acm.org>
Date: Wed, 25 Nov 2026 15:27:31 -0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] DMAR fault by Intel H97 SATA controller since
 "block: Increase BLK_DEF_MAX_SECTORS_CAP" (6.17-rc1)
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>
Cc: 70sp <70sp@protonmail.com>, Laurence Oberman <loberman@redhat.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Tobias Laas <tobias.laas@posteo.de>, Damien Le Moal <dlemoal@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, regressions@lists.linux.dev,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de>
 <awSs5Cw3hFkf4O4T@ryzen> <ec36d13e-e4c2-4bfb-8b50-69d4a1628839@leemhuis.info>
 <87b1bbd8-8113-4890-8623-738b19a9cc7b@leemhuis.info>
 <a0ff3156-add0-4f7d-8373-09f95bd7036b@acm.org>
 <2adaf0ef9e1a2fa18590f7d8dbf203c0f7de2be7.camel@redhat.com>
 <uJluFNYGCCrdvnYT3MatN_4Om8UczTJX_dzxumJxyCAC7F-Ubrekb7LPwlRxhCW0J91UBf-TqeRoJQfgYIYBRvMsPmE-Qs1eAg5zbDP0s58=@protonmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <uJluFNYGCCrdvnYT3MatN_4Om8UczTJX_dzxumJxyCAC7F-Ubrekb7LPwlRxhCW0J91UBf-TqeRoJQfgYIYBRvMsPmE-Qs1eAg5zbDP0s58=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/26 2:51 PM, 70sp wrote:
> as I mentioned in the referenced regression thread I reported, the
> patch I sent out was basically an example to show that it works for
> my use case. I wrote that I don't think the patch is ideal (in fact,
> I think it's an absolutely terrible solution to fix this). This is
> also the reason, why I just sent it as a snippet of code.
> 
> Please take a look at the code before the regression started to
> occur. It was implemented universally. These vibe coded patches are
> horrible compared to the original code. We are literally making an
> exemption for a specific CPU in a place where it shouldn't be. The
> actual correct solution would be to make a patch which works
> similarly to the pre-regression state.
> 
> If we are going to merge something that is made by a LLM we should
> at least make it good. Ideally made by an actual human.
(+Lu, Jason and Joerg, signers/reviewers of the patch mentioned in the
Fixes: tag)

Is a better solution possible than the patch "iommu/vt-d: Disable
superpages on Haswell with integrated graphics" I posted here:
https://lore.kernel.org/linux-block/uJluFNYGCCrdvnYT3MatN_4Om8UczTJX_dzxumJxyCAC7F-Ubrekb7LPwlRxhCW0J91UBf-TqeRoJQfgYIYBRvMsPmE-Qs1eAg5zbDP0s58=@protonmail.com/T/#mc147f250c5356e3742ab3d30ccf6b4a3a8c4196b 
?

Thanks,

Bart.
