Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72D3E51D4
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184295; cv=none; b=RiPhIWboepfPiOun8Gq9TnYwwe13UgKgCx7pCekIV6di2IfofHlrcYOPYo29OhJkBWdq0inQMocVugW7XzrEK9EGTjsaDhl/alEI/xT97Pg6VGONVrFSbvbC6wuanBtfLqQGge0TbGz9k8JexAAW+N6BZ3i4H2HuL+/KzX2+cT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184295; c=relaxed/simple;
	bh=zPbFyXkGlwjReheq7U40lvUG8BvJVpBYL3Kcj7fW/JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzDl2yd2t4Bz/ZEKuaX0GhV12ATTZ7j0eNoQZ3NIWf5/PwSwQknMzQ93yPE/94mEywVHZsilpFTCSVcS9MwdwW1d4wDqQ0KnECby32fzNsvwuALjhyMHTcRa8YcahlWw9oTM2EO/HnTWTT3/6aN4cAcZTLF0/LrOX9/3UW1qHTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Xti/g4oe; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xti/g4oe"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7f4f1354074so303666a34.0
        for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 10:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790184293; x=1790789093; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zPbFyXkGlwjReheq7U40lvUG8BvJVpBYL3Kcj7fW/JI=;
        b=Xti/g4oejonP6fApJqsjjvxsWOeiUlY+g4IPEEehW72PZ0LpJr9fJcA4jGWBz3dvgE
         GuwlY90ye5NxmfcjqxJx0AmRizGvX9L76liZ/v3xRxPjI1AplGqtkeiXrJzWl0kIf9NE
         f44iQEZIbVPXudnvytfmH1qPkEVzjuf+sbTXjdSrKkwVmcCtqtNyzMMDx6dTjEYXvGul
         gg/gwttwat6uCwqVrrr/HEtN+bXYSN8Eo/u89SoJRHjKQ9P4aIS0x9nU7aUrKZinkTql
         0g3+ggIokBCldsGc7rqsBE223iYHKyZZKwW4KzpMxDgLKMFHnq444cHuvNEv3wl3H1tZ
         es0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790184293; x=1790789093;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zPbFyXkGlwjReheq7U40lvUG8BvJVpBYL3Kcj7fW/JI=;
        b=VOGygCJgw7UK03pzayvgak0Wz6GqgDekdeKDgR6EAk67aCnducqNvHn71kALELHYxl
         RexuVIZX0XVl55dB4xyD4CUqo3kAGVofT6BoP/6ZcjvakQDXEgRinkXq6ZGkyazBrPKs
         u72bhEtF7JRkSrBTujsZzYyu1i6/Pj+AZzSxGGlvsjGAuILINU28Hr+w1umxj2kPgjS5
         CWft2Kq3foCkDVzDSySxlUcF+WEsrYTRMt/8/QVRW8DFA8gv3aRACthEAshQbXHtnttL
         l9NI23/uZwQznKeIRXBzFHtE4LChmCmKInx1uK0qWfYakhTddjvxsTw4hru15HfEcUOW
         5PVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTY5S6h1ZynzKGxbF5rc7lLgOzsDehUgf6UJejZyw+DkSx/EuIqUEkrKm+30STN8Gf8qj0eg==@lists.linux.dev
X-Gm-Message-State: AFuF++l+D1e2K3aIuzxPyERH+Aa4jjcni1a6hLFXtfT8kmmpCdOwblu3
	F7kHDh/swfJyqH+pnYbRc3lAuHoWk514p3LK6thuo9oiEyfawMk9yfdB1XA8wl8ZgcI=
X-Gm-Gg: AYBFou0YIz4LZFc2I4ylO6/KhtZRwsL0sh1vhzFmXfLf+97zyOboIPfkabLUgUR7Jej
	/ZMz9eeKlxZBVMgXMZ/FMxJWtvJbQxbJOvnoza3119Wsw6a6PgRjTbFLMnjss0ESt5anUtG2Ggo
	Bg+oigDp+uK8UBc45necEs6cRRIfkyEYHUcuqOpgGfMI3eWHDXya39jmd26rx4u12ISz3tOCwMw
	Ol+ijMRn38oDO4aVShRQNSQiJniMzkogAHrAJ+mb7vANfjAN9FxIG7I68wRjIOH/rwPRDP7TJ4/
	6DEaB3Di2NH/romMIcIkSivnjgKppnfHM9base2XbVbqlbUtLQ+a1UNWDOOq6aOy7SWeExPVPX1
	5fnnB+66zsG/MLMFNQ3fPVC9qWOmFyv2v68sFG4F7KXjKPjFHHGhYusIt7C4QT1WXrjeN9jI+1P
	CiOM8CcPsfnrohEhl+qXpPp6pfEYUDF430Y83IepMpOwuQWqs/wj6WkG8=
X-Received: by 2002:a05:6820:820:b0:6b5:ec3f:4985 with SMTP id 006d021491bc7-6d2cb7abb15mr2482311eaf.32.1790184292712;
        Wed, 23 Sep 2026 10:24:52 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d2ce25c058sm2994831eaf.5.2026.09.23.10.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:24:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x9QiB-0000000EA0Z-20hw;
	Wed, 23 Sep 2026 14:24:51 -0300
Date: Wed, 23 Sep 2026 14:24:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Morse <james.morse@arm.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, alex@ghiti.fr,
	aou@eecs.berkeley.edu, babu.moger@amd.com,
	baolin.wang@linux.alibaba.com, ben.horgan@arm.com, corbet@lwn.net,
	cuiyunhui@bytedance.com, Dave.Martin@arm.com, fustini@kernel.org,
	joro@8bytes.org, kevin.tian@intel.com, palmer@dabbelt.com,
	pjw@kernel.org, reinette.chatre@intel.com, robin.murphy@arm.com,
	shuah@kernel.org, tomasz.jeznach@linux.dev, wangzhou1@hisilicon.com,
	will@kernel.org, xiaqinxin@huawei.com, yuanzhu@bytedance.com,
	zengheng4@huawei.com, zhangzhanpeng.jasper@bytedance.com,
	x86@kernel.org, iommu@lists.linux.dev, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: Resctrl and I/O
Message-ID: <20260923172451.GN1540250@ziepe.ca>
References: <arKx__kOPe4B5gDW@agluck-desk3>
 <8557363f-c051-4267-9fbc-f4cbb13ac35e@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8557363f-c051-4267-9fbc-f4cbb13ac35e@arm.com>

On Wed, Sep 23, 2026 at 06:13:27PM +0100, James Morse wrote:

> Using iommu_group like this may need a bit more thinking....
> If we can fall back to using a device as seen by sysfs, then the arch differences
> here could be invisible to user-space.

Please don't codify iommu_groups in any new uAPI, that has proven to
be a problematic choice for VFIO. We undid it.. Lets not repeat it.

Jason
