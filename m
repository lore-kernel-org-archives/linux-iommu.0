Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546936;
	b=k74uUXvb8iMbhnclcJ1nxR4tEk2YlM+fUF4XWFU81kZcgV/3SQvsfz4KD7SJODL80la2
	 S58ElLx8QJtXFXPlRTGVuQy0jP3UajtMcY1A4PqS2dBKw23MpBXbsAQ/Coffl1p32C/N8
	 wtoyuXJEOPk4h9VepVli0OeqycnR75EaaLcykWxQqfcx8G0L9BKsad02a/FaYulVe9HM+
	 ckp4vHAdGw7/hHGxfY4EHXGiDO1Wa3xg/DGgSRH9V++uKu0f93yrNKM0qC3J/Or1lPilf
	 /ge0WXn+QdB2BY2z2FyleJUJGTTZA12G97X4cAOUrGb1hyCviq77rLjddkwGTBG1KrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=vmPlBJsxyoTZOO9g2mmGNuUfH7b/frSSah/ZWuzVmhc=;
	b=cQzYkgJF8/91GlCOJ1lPjS7UdzUqibncckBWg0MypAti1odPgiyiXZGPFaQjbadJNzqs
	 QAglxUQtFXul3tw/4W/miL1hJINpsX+BiUS9+lsM9Dk7e695eJcZ2mfLKNg0K14r9IBuP
	 pLwTsff8LnokAjeTUNe9Z6DYyz6zwplM371kvvEZA6+8pmBsArWhXjo6NaVxyO1tP/+ye
	 ERndo+eWfrhHRySmyTiNqQuQke22IW+dlagydJUqgr9hIUayMnf4JFX4VJDfDZgAqI4Uf
	 fZALZF1unr8T/Nd5I00892DQNMc33vjDQPtJ7dloSWRJEYNZCgG5M4GzksCA9YOwGJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KN56XpNr;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C499F606A329
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 19:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C499F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KN56XpNr
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b66d1a08ccso3432862b3a.1
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 11:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795546935; x=1796151735; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vmPlBJsxyoTZOO9g2mmGNuUfH7b/frSSah/ZWuzVmhc=;
        b=KN56XpNrGj51CXjSAY7lzcawJYoA2NWATZKstRc6ZCl0CmJQnvcIdP4EsWw/ffhhUb
         KwPaigyyPAcNEPmpCIRWR40tte3ebqA/XjVFozYdwu5XJWx/TANGHXUg80Py24XBb1Xm
         1FFyUx4eVgouSSfONFBuxKZVomuOEoltFDcYS+q48Ywfif6rRP28uHXfI5oCap2I0jEf
         fpupODx0DQuUyuBj60rx3PW3A7buGVJs1ZyPSFBHcc3n4M0eO1txfNPEh67P5G7wd97z
         Re3vKcYPjngYnFolCBfA04eRw7rxoef18o/UtA/uFeWcZpe6+CmruVq2TtkDE2N2hc2T
         Q+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546935; x=1796151735;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vmPlBJsxyoTZOO9g2mmGNuUfH7b/frSSah/ZWuzVmhc=;
        b=oRYHOlKRWF5R+xNQI+PiMBKo/dNfU6aGU+NdVWJR73cxdcTGmLK9ioLBdgIZD2kGvP
         offJQsbiP3srixA0bmsYTHQ7N7dkbIEBOcPWRqEmRjWmbhh2c2cGQrqaoGsRrcR0CQ9f
         Aj/Jhb7ABlOhYkqilP63WmIeKjMV3zoRDQTYHza9CBVl/+4ydpJ5JaV3a53oJTJbGVUu
         PhvcXn4gMVd1KtARfn4y3Qq8M1dhM0in8aUGWxarZfI/DMoi60inPPq81Rv/0ONabkHC
         /rs4SuU1cLLIAofTjwU2evkzB1GAUhAbtkO9Qc7j/y/HhP80SazSt/pvWio2l5daF81J
         V29g==
X-Forwarded-Encrypted: i=1; AL+hErHxvk9ivzxgL6AeESKGYR7hzgtfDN0rfZRCBRS+uAbW6JD6x9Agtnv+6NIFKDybFLscv4IFMg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9mpD54lK4YT7XFaH1BFvYF8rl33iHRgPz88l/r9YtblRjkx+6X
	HLiJ4qDQ6crd3W52V9EzGFZ+tvwXXsylHMKs1+D8I1TDqiuc3CgZIlpJQUOK8qG5zw==
X-Gm-Gg: AZFdTZc5cpo1V/XYSlbcku1SpaYPsO1Idz4+BtN40ZBRi9M3cgK4xQLkrn0K431IKog
	U58dXVSZcdrhwof0sJRuU7z57VRU7l0qC1QFI4nQKjSIZifbEmdxCXgsGwPqOFzokzCuJ0GectI
	cGnLtGth/tSqnVeottNQfTMJMjR8LrLLOSBk/eT6+ez6fSb+V1/a0heqv5NpLHbP+ZmvH12dgqC
	WPMlp9EEO6+yvIXjzXDdGQW36cVTK/D4swfksSLwDb1NfFiCWqPnRQ4FTe0ri0ZeCK13++dlxoO
	3Q5og41qy6aF41NmJ0p+gRffIds3PBALi4kDdYfFpWqNdjkynZfHnv5m4iJIhXEzgrdoYtkHk8q
	anvaf77InO/rD/asVhtUkH4xjnjMQBJr5dF+2f34yb03R4Y7Wa4bTZmaqgZrHKPg4Bo77DXL6pn
	GVoLY2DH2icPEfBIZ9QI6Htseu0P2ZJpcaIdt622hov4ogud/iDILBkSSDPZHZCmFpLBFZgksTh
	eQANxvKwJxFKieBIjhCPT0p2BZPww6TuOGnXzeI/Hfb/QB/FHi6mVyjCzZR+htbjGz47vmCmRPa
	RE/+h+1kXbbv1+iRbnfTJgrh18dYMZ8FwfI1i0Pa3zs+6qQfAvnal8MwYJzD+F053A==
X-Received: by 2002:a05:6a20:a11f:b0:3e9:f2d:d556 with SMTP id adf61e73a8af0-4014ca44d17mr16159174637.55.1795546934090;
        Tue, 24 Nov 2026 11:02:14 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde9bb05981sm2247135a12.26.2026.11.24.11.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 11:02:13 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 11:02:12 -0800
Message-Id: <DN3O9LHR4XNH.1EYLA6D1F0J2P@google.com>
Cc: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, <seanjc@google.com>, <jgg@nvidia.com>,
 <loganodell@google.com>, <arnd@arndb.de>, <dwmw2@infradead.org>,
 <baolu.lu@linux.intel.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 <oupton@kernel.org>, <alex@shazbot.org>, <gle.com@google.com>,
 <pbonzini@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 <kevin.tian@intel.com>, <joro@8bytes.org>, <kvmarm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <kexec@lists.infradead.org>,
 <kvm@vger.kernel.org>, <iommu@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <skhawaja@google.com>,
 <sagis@google.com>, <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
 compatibility
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-6-tarunsahu@google.com>
 <2vxzse0rzjdn.fsf@kernel.org> <DN2RQ7LGX224.3W3PSQ2PBHTJZ@google.com>
 <2vxz33sqz1xj.fsf@kernel.org>
In-Reply-To: <2vxz33sqz1xj.fsf@kernel.org>

On Tue Nov 24, 2026 at 7:25 AM PST, Pratyush Yadav wrote:
> I don't think it buys us any functionality. It just hides the problem in
> some lucky cases.

Following up on our offline discussion: I think it's worth keeping
support for optional features, both before and after the spec changes
land.

Before the spec lands, optional features are the only way to enable new
features at all. For example, the PCI follow-up series [1] preserves
BARs and bridge windows using an optional flag. It's purely additive: a
kernel that doesn't understand it keeps behaving the way it does today.
With optional features it can be enabled as soon as it lands, and Live
Update keeps working in both directions, including rollback. If every
feature is required, there is no way to enable it until the outgoing
kernel can learn what its target supports.

After the spec lands, optional features are still useful, and at worst
harmless:

 - Kernels that predate the spec mechanism can't provide a spec. As long
   as one of them is a possible target (e.g. for rollback), optional
   features are still the only features the outgoing kernel can use.

 - The outgoing kernel doesn't need to consult the spec for optional
   features at all (less complexity), since by definition the target can
   ignore them. It can always produce the same payload, and only
   required features need to be gated on what the target supports.

 - Nothing prevents an outgoing kernel that has a spec from choosing not
   to set optional bits its target doesn't understand, if we ever want
   that.

The cost of keeping them is negligible in the current design: the same
number of bits in the header, and one range check on the incoming side.

The one rule we need is that optional really means safe to ignore, e.g.
optional data must not reference preserved memory or carry restrictions
that the next kernel has to act on. Anything like that must be a
required feature.

[1] https://lore.kernel.org/linux-pci/20261019213054.3157159-5-dmatlack@goo=
gle.com/

