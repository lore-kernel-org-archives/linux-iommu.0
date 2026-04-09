Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543122F549C
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749094; cv=none; b=Mby8QMP+rdps1OHt3aZp3ad2qPkCS8ygSPzN6DuWf522087ak1i5KNS/G1noc6Wx860tsWtlBJUvyT5QWlDce+yivwBo8Lq5Qu3W5klP4t3hChtJkTAYzD9pLVmN1+In3V5nUL8mJSyWVgnCct+4zbaP7jM3XZvB4JcWA5YI92Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749094; c=relaxed/simple;
	bh=PqPVYuoHcB9VbWWRLwQgWRPkMClKIoD5tzzfx+rg4LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohVIhIhLIb74wI6qArzPS7fW6bNR7w1JZJbHBYCSP00s6cue7qwi4cvpTZP8J/hvZysn1hVKw7aOCLsV2mvULxdaJdSeB55GT9nDldcI9ff/oKHgVAzvsWVgrQurVbkqRK1OFTrwn5uVFHkIbOoWVZG8yx2rPZg1Kq5wrvk5KPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dJJMY+sG; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dJJMY+sG"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so1455989a12.1
        for <iommu@lists.linux.dev>; Thu, 09 Apr 2026 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775749091; x=1776353891; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=umW1IQdOAOPjgPj9z57AnteG7vvMbaLS+TiyzZ/vV5U=;
        b=dJJMY+sGX0nuCejmEAkcEjP9GR/GssUIE5gL3NzyAUeAmMmc4SJEQbis8Cxpl7Ckv4
         c2C2UnPQomUPgbUHXVQyE8cQL86KHZtyo3gE8AMAESTgqDP5+jJp3S2EM6vFuaXCn+Sy
         stdMVuyCvN3MLJ1EHa/8ExvFk1jTjKfBrgsYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775749091; x=1776353891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umW1IQdOAOPjgPj9z57AnteG7vvMbaLS+TiyzZ/vV5U=;
        b=kqLAFy3Atvrs0F5Q1v81tA7mE8kczoUamjnpC+XFl8I6SINwbVEhU44gRm8lYqOp15
         izqmZ3GUZ9TV9bxOi41EXFlTZ/sJpK3sCl81tNIqoAzIIaJSkjBAlJkg0z6eXeWdYi2+
         l/7hdyBnDs5rjT3oTTVDJH6XPL4OHXrTHUj4eQ3vFSw8rhoJZT6R/exWRRjuX4Pf5ZuC
         i49deQDjsx9k6ROMer0FgJ5gqZmTogu4AgYHywrHk5uKmbY4hru3/UpsD9fVsg8eLKTk
         dFsUCjZ41rGdWGvmi0aUkellvtWNmQ3eMeJp6wbegddGGpfZGyqPr1d3hjA6f3LLbHYV
         HElw==
X-Forwarded-Encrypted: i=1; AJvYcCWdRNJjufp7CukCqLRWKOpgbWtu9SzhdVhYc0OzrBMzHv0sDzmiVcqCMZGvRzW2Vz+Y6t54vg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyY/JKX92N6asJV+otkIqbvmDFT6dS5mwp7GS3ZzRz8PdzygYMF
	iV3HY1izP8MqSoxDXFwVxBEgw3RAvDNREV2NFwtR3CRk7tjvZZg+7asqoMhhLIJ+83YD+PuBz2d
	DPAaI6D8=
X-Gm-Gg: AeBDieumOrz8Sctz/Jc0mSoK7N0Nup1Z1ZXk8mh9hW/jINV/f842h2XSAmumPqLcXzO
	mR5+E0h+ecCfHbKncGEorsv8obhkuMvOMq9DpN2BpJn4tz+Puk2P+YgofozILDWfRCFXeSWGmTt
	C0n7l9t3WYJ7gSEALoY/+63tEgbZwMoUn6M+4d1AgX3hC+aNfiP2UEjuFxE2MckiQxFna/Slmt5
	vTPUegkc+NWYKX5JEdr8oJb1f9zWAUvtWnNlGqaViZBVE9d/97O1BvxL/RcyAwsMaZNUVIp4zYK
	v8kK4ZyYWmce5p+peULAmEojnwbR1I+24c8d8EjElen9ag/9S1sv3xiPtvyUPnnPRGPDQlSKDnU
	PtaVftRLBlYSRp91lproxkzqGxiyrcmtJlVHljUA4dCVjLacfhMT5lJ+PQ/deNAfb6qIXpcEKWN
	xuzk4FPkeh4D6anQxRMD6yPs7O36sFsPWURTpyQkEyLvl6cUqmPndWnLcqg6Avb8bCZTPaqe/n
X-Received: by 2002:a17:907:ec8a:b0:b97:c719:14d4 with SMTP id a640c23a62f3a-b9c677fbd18mr1258240666b.29.1775749091455;
        Thu, 09 Apr 2026 08:38:11 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7f189esm2573266b.58.2026.04.09.08.38.10
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 08:38:10 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b982b0889d8so142682666b.2
        for <iommu@lists.linux.dev>; Thu, 09 Apr 2026 08:38:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9D9Wlt0LOzmNQkxgvP5IjjzkU5SheukvEbikmH92FEFYP9mX8FNTp9gUJvndiUEsp3KJkxw==@lists.linux.dev
X-Received: by 2002:a17:907:6d0c:b0:b9c:94a3:317d with SMTP id
 a640c23a62f3a-b9c94a3345fmr1104212166b.37.1775749090683; Thu, 09 Apr 2026
 08:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <adZTGOjjJrVJOcT8@shell.armlinux.org.uk> <adZfTi3R6jtsjXx-@shell.armlinux.org.uk>
 <adZ9grUg71f518Fg@shell.armlinux.org.uk> <adZ_ZmjcE8S22vR1@shell.armlinux.org.uk>
 <3a1d0520-3402-47b2-9d7b-4e14a3cd07a4@arm.com> <adayAMR_dEA6W5vW@shell.armlinux.org.uk>
 <adeaiSAnkaggqPsA@willie-the-truck>
In-Reply-To: <adeaiSAnkaggqPsA@willie-the-truck>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Apr 2026 08:37:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whO3F1u+nme4cnYMy5baYmb7CH=wE63dcNaPLWD0vKaew@mail.gmail.com>
X-Gm-Features: AQROBzBMqgTUhWghYpRNIZDpsOWA443UoVRzdGjObC6SoT9V2ssj-2Muj4chrOs
Message-ID: <CAHk-=whO3F1u+nme4cnYMy5baYmb7CH=wE63dcNaPLWD0vKaew@mail.gmail.com>
Subject: Re: BUG: net-next (7.0-rc6 based and later) fails to boot on Jetson
 Xavier NX
To: Will Deacon <will@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Robin Murphy <robin.murphy@arm.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-ext4@vger.kernel.org, dmaengine@vger.kernel.org, 
	Marek Szyprowski <m.szyprowski@samsung.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Apr 2026 at 05:24, Will Deacon <will@kernel.org> wrote:
>
> On Wed, Apr 08, 2026 at 08:52:32PM +0100, Russell King (Oracle) wrote:
> > What's the status on the iommu fix? Is it merged into mainline yet?
> > If it isn't already, that means net-next remains unbootable going
> > into the merge window without manually carrying the fix locally.
>
> I'll pick it up for 7.0 in the iommu tree.

... and now it's in my tree.

               Linus
