Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95DA1DE8B2
	for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737034470; cv=none; b=clA/LXQ4iBDKgqc9ahoK3vLXMuZvBC4U+aewT+Xc8ZOHla1v9KKEicsP/kCo1r0yGCK3wNFQt+2JUKHRd/MGAB6Jgnw6DsmAfOgmeQ3K8TmQll/iw8k2dRsfd8cqcUEq33NtdrzRSmOMAAuaCSnIktJwxyggmBHn0qb2nCWXocE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737034470; c=relaxed/simple;
	bh=4AlYFJT8Pbi6L1LPfbIROwds8P8lk+z7W7/xjXecyrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxlPkHAk11rBp6FuXLCPM+Wn4s9rHAA9JfDxxnPABSJ/8F252B6MIEPneBhJzjGt+etRZRkcESubRPglolRVTj6R7tZUa9EAWYoKwBFkQPa2QZKBu8JujDqDpTT5YI29SRjFE7cMBQ4DQPxst050pusIvrDP0URls7qVye8hh8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d9b6b034easo1948796a12.3
        for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 05:34:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737034467; x=1737639267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVe60wg+lBRnta1bqmFy0y2BGJWsXtB1Z65Ho0qku0Q=;
        b=NJ/U321+mjceYfcDdPLdQo8Mwoh3nPqphNAqFfr7ZS+kLZLsj7oyAZRS1zalFdcMOn
         uuNowNpstG32cbaeV0X4uY2JAsyKydSyYp8MV9dp7aUB/+wBbOz4tdzQzHxVAL1/HGoj
         6XiLlZaO7aSHSlcHBIOPngKlvhSbUZJC2q1U7wuDSMk7sYRE6fPJv6S1k6zhQiJ6oHMz
         4V6zm1rdrjA/w24SAhKgqHerHVZ/JKsE9CYOrwzhdwEusWwoafbVyASRGJtnXu+BM44o
         SMlRhNk4SMoFLzNLVFtf/tqkTG+T+LpSuaMCOxRn1a3sfVQpZ3DGlYX3R33CPfyGGZYN
         ucKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZeoA3Pfj95EyzDYwQIBO5TDFWuQrZE05U4jml/BGrQyRATvxWnFVGa6Xtv/7fgr+dm+DWag==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMT/Yud7cGOENnuOI5N6Hp89rj81o7KvTJefZIJB3s5aSVWwRq
	L8PSt5mOm7cyiUGlc8fK6hgAKqHshPxS/i1kIQ2c10dk22gwyzPl
X-Gm-Gg: ASbGncvP+emBd+e3fyRoQMrn5vhEmPj0VwW3MBOZHsFEFWTNmdtOlvZg1oM7GmzjnMo
	CbrRsb5+idPnwXUifG9+rcfsE1tMHGO5xKAoKIv/FsFT2KiJuKdYAw27oXxlR9wxcNuUgg8FVaC
	3LQdoRDAbWVuouNZRHBW/H4LxWBBA3fGr5/H1VtzNUDbFL2Ce4xLBADPSyhaF6fQX9JiN8tqRpI
	jprtfvDhC7Zq/IwZiRmE4teJkCABTX84xLOhWZJ1jkxNvo=
X-Google-Smtp-Source: AGHT+IHtYQNu/MreF8vaipVwQK9Jbygxo12F5QwFq8ok5wSDVVmvL8xvzHcaQzGEHrOn8/LN+Kh48w==
X-Received: by 2002:a17:907:1b03:b0:aab:eefd:4ceb with SMTP id a640c23a62f3a-ab2ab66d63cmr3465766366b.10.1737034466743;
        Thu, 16 Jan 2025 05:34:26 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9563c10sm924750366b.92.2025.01.16.05.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 05:34:26 -0800 (PST)
Date: Thu, 16 Jan 2025 05:34:24 -0800
From: Breno Leitao <leitao@debian.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Ido Schimmel <idosch@idosch.org>, iommu@lists.linux.dev,
	dwmw2@infradead.org, tglx@linutronix.de, peterz@infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: Suspicious RCU usage in enable_drhd_fault_handling()
Message-ID: <20250116-ludicrous-mature-ferret-8956dc@leitao>
References: <Zx9OwdLIc_VoQ0-a@shredder.mtl.com>
 <a45ae593-20b0-4604-bf2e-2870b2c7f11a@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a45ae593-20b0-4604-bf2e-2870b2c7f11a@linux.intel.com>

Hello Baolu,

On Tue, Oct 29, 2024 at 09:15:55AM +0800, Baolu Lu wrote:
> On 2024/10/28 16:43, Ido Schimmel wrote:
> > Hi,
> > 
> > I have recently enabled CONFIG_RCU_EXPERT and CONFIG_PROVE_RCU_LIST in
> > our debug configuration file and started observing the following splat
> > [1] on one of our machines during boot. Searched the archives, but did
> > not find a similar report.
> > 
> > Not sure what is the right fix as I am not familiar with this code, but
> > I can easily test patches.
> 
> Thanks for reporting this issue. I've been able to reproduce it locally
> and will work on a fix. I'll let you know as soon as I have an update.

Have you had a chance to look at this problem? I am still seeing it in
6.13-rc7.

Thanks
--breno
