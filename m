Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FFB179BC
	for <iommu@lists.linux.dev>; Tue, 26 Nov 2024 02:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732589123; cv=none; b=O8vues7p3iA/Cni7dgH4kmPUqlEW1AUpR2puhmlf7rkfG7NwUtT0huW7h6wJ6uNtvzK7Q/uzjGJdco7FSnq+VYfglWqWYPlOUSWhWl6+Yu89ggUmskBw1d/VM8XSZ0MuyXd+XQctBWzWkgZmhtSbbDcVtAXPMSxR/kNv7DW/59o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732589123; c=relaxed/simple;
	bh=YQIwdTt6cxgmVXfOJhj/54MLx9mAGl57houTp14qmmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIsLW5wAYzKMYk/ZVQ/4mCCchIwokI5nVSPXIntghriCH1LvBufyxmGOrqS4DQbYoJEQnRXkY3HMCUJ06UxIGHHdt8QtsqdYwSOGp4lQNX3eyR0/2RbmIlIlWLx++AcJxMx8ZXEJZ41mOa0j2pvkQCZJTXumC+bPED22dLSVEng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dxqOq7gA; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dxqOq7gA"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa52edbcb63so484056966b.1
        for <iommu@lists.linux.dev>; Mon, 25 Nov 2024 18:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732589119; x=1733193919; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=quBmcrD650pEIyPTImDpIW0ZSz5rzhaGhAnMOzpggdI=;
        b=dxqOq7gAuuwCH14ky9MJlSb9ofKiqxSHzDwyCPUZLkeF0CXHRftvZAdKEWJ8X6xrwc
         6yZGjY7lcTTN8ibGU9AmZ6kzMsZWnu6lM3yyli+k3M/5XPY4hek1uTsU1xBRz6sL09uw
         moITZP/xPgMRIRd+UkXzHwYfcspHxj6BuR/tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732589119; x=1733193919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quBmcrD650pEIyPTImDpIW0ZSz5rzhaGhAnMOzpggdI=;
        b=tiXtD4a2GGZKmYbv+wPgMWLdAK4D7oNcLPOmuphOsRAnB7BFt5giVdGcolZtYNHDHN
         ijSOPX4TUI0Be1AP13S48kWNiTLzeTtcXuewpGjW0N4ObVmwmZwvzKi3M85joxnRqspL
         NYA2dq8BbrcPspmD5N5rTrPUHFlAP9Kee01vpkme59UZ2XRNMeVxGWpVUfacnXzMuNX7
         +kpMUXb4o3KodnO/ujsvTY+ESgrxeHwbeuImBiA3r+R92xYL99wRvbUaDo7PsYVZewmR
         EBW/Je+sw+/DMCX7VItRRRcLm+lIYh8LOAZ82BuXzciYrzxbyechfyW3VaV+cLaSFKnt
         HV6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfVdV8LO5YnkKYAGAg52O6FOWZzC/OSTRt7gjm6ua+6k+ifQ2Hd4wdUZ/iOwJS8gsWtMBqIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxaAdIMImg8ZZQeGuZhDdnXiQgLZLn42D93mxZHfnpBBCkREbL
	et1LhysZq/r7aMDro79ZWULwx56LmtzS4nWsNX06hPggUxrAOe6aiV7MwHZ4P9mUFR5NYfuJGxG
	XB2FcYw==
X-Gm-Gg: ASbGncvKi9PPTXfiWZ5gfaz9yflsX/nkmyXKgllCGmt0X7vnPDkHhzw5M1Qs/0PwpGs
	7GuU2RUXEaHDmoGqUak49mkBWwhOrEeUZoUCNAvNwerk/T8QeSSEitpHDfvwoNhuODvUuOUDrzj
	516leUWwPQVsPrsNgdONHysowjKAb8M7h7KjviempCcojC7WBCm3p97vphUfNJObluA0Qsgv8d5
	itOnD31+FzXT1YW+9UM0Ga4IZvuQEL3c4drUv9w6GyVsGNrFgj/tSartRfkw7XGRoJvEYpSIHQz
	iN7JixNGHpAAIydn3suXz3VI
X-Google-Smtp-Source: AGHT+IGICiJPaFTUJ7U59zSDB8PQ4sNwLSroxWDTMbgTAPa/fFoN3PtKTyHuh+pEZMKhFYuZZ/943w==
X-Received: by 2002:a17:907:2ce3:b0:a99:fcbe:c96b with SMTP id a640c23a62f3a-aa5649cf3famr125002166b.25.1732589119092;
        Mon, 25 Nov 2024 18:45:19 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa534232086sm398239966b.42.2024.11.25.18.45.17
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 18:45:17 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa55171d73cso280807066b.0
        for <iommu@lists.linux.dev>; Mon, 25 Nov 2024 18:45:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkUS+x+jOPDSkUtUdM5Yl3bd2VyeVUJGmaF65Be1oosN6rr63pXtybIdYPjye6gbLtPu6MBw==@lists.linux.dev
X-Received: by 2002:a17:907:6d07:b0:a9e:82f3:d4ab with SMTP id
 a640c23a62f3a-aa564891110mr139123166b.9.1732589116714; Mon, 25 Nov 2024
 18:45:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJwJo6bu3vfogmzxpfzFV_guf5GS_1TsqdB29NZoUr-_6fd8pg@mail.gmail.com>
In-Reply-To: <CAJwJo6bu3vfogmzxpfzFV_guf5GS_1TsqdB29NZoUr-_6fd8pg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Nov 2024 18:45:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiG+jR7TJdCX_Xa7_dbQP8wU966e8eimUs48VVG9ac0sw@mail.gmail.com>
Message-ID: <CAHk-=wiG+jR7TJdCX_Xa7_dbQP8wU966e8eimUs48VVG9ac0sw@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.13
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: pr-tracker-bot@kernel.org, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, open list <linux-kernel@vger.kernel.org>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 17:46, Dmitry Safonov <0x7f454c46@gmail.com> wrote:
>
> It seems to have a minor merge resolution artefact: iommu_present() now
> has a header declaration with no definition.

Hmm. Yes. It looks like the merge in commit ae3325f752ef ("Merge
branches 'arm/smmu', 'mediatek', 's390', 'ti/omap', 'riscv' and 'core'
into next") is buggy, and the iommu_present() declaration survived
that merge even though the 'core' branch that was merged into it had
removed it.

Those octopus merges may look cool, but you should never use an
octopus merge for anything that has any conflicts, because they are
hard to get right. Joerg clearly didn't get that one right.

I'll fix it up and remove the left-over declaration.

           Linus
