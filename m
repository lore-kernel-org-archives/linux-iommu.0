Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321F31A2C0B
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841060; cv=none; b=q+2XfApTmRA86E27vCP/LRAZj3vgZgtY5Ja/dmZSgI5e4R+WkkyKwJi3tNTrCcmU97+IeGWggKINaOwrsXGutBISH9FdW7r3zbewi7jWzVprL/SLZhHUz4n3pvRDjctMdzeeIrwtB11cU8h+KvaFnhpEPjFmvhDK0m8l3tiHBwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841060; c=relaxed/simple;
	bh=6PWfkKXT/AMHAqxX7cfEJo3L2lk7EqER7ygybDmzlBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFAGqfS+DRKhFCDKVXWW9rWCqfB3vynCPQt4QPqCnR6UJFUzk2rt5tct+IHw8s1lcQYLi0kjY+igQmNX57osoGmN1JbctVTf7ecodY6nziquBQQOiHxF4cJBD5GeK0psqDInQI1Q+GxGxJzu0FJon6zjE71VV20eGuB6OmvborA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPVTbMjV; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPVTbMjV"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-844ba46e0e6so64600539f.0
        for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 06:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733841058; x=1734445858; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2N7XAtorM72yACmDgop2No+2dzqpehTFwae9k1iios=;
        b=UPVTbMjVkXhOfKH7RucU0UIksWvzbjwlS+ILD7Uns2GY5kRQ4TqakCE4KRLoTWWwOi
         aUg4avoCNCzF1Si51QMsltbJV8fm8F+ixhNwnxMAdBEtlaJJ9bCzcfxjBiI3NQhLOMB2
         bVfq8YXQT3ahkDf9735il76RuqTc87WKxq3VSWF3wCFZbix9m5AvpLfXqavuNcZ7KXyI
         w0/fXp7+yL+KBWi0yPn5HXk9qcMIPp0Kl2ZeA5P2OW7Pn+VisXY7LkbqG7tlLMLbgwXM
         +uoRljQAtRFwEsuVi4iStK8thEskE6m+O2V549jOQp1ep0I76wScGvdIexhft1rP+gGD
         KQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841058; x=1734445858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2N7XAtorM72yACmDgop2No+2dzqpehTFwae9k1iios=;
        b=FwJiWLne1rWt9oSXpu6SKT0M2wghjXsrSxwOTCX/R7e/aO13w5vBSnZnXTvu+ZZZmI
         VuGZ7UPg6utqQA+KbfM02v/kJzGYrlA5Tq5yY1uI+8csGppZ4oQgpevuqjuoLysCfDKw
         1zn1EF1NxA48uLWJ4EAhEEvLXHfJT5qBJJVFe0tEuiFlRPxxBFmTE2i089GFAWPOregn
         Fxo3pTE2T4TxS4EneXv2nPW+jBV8j1k9mAAKCCwPeuC67oYnMLJK+JtaQWq8NLADissw
         +Z6Exn3YJMvgSe54cWk+Qc5BNv5v7+HjC8pjfIvo1bjaPKqT0Oiev5FKJjIUB3zTTT8g
         IIDQ==
X-Gm-Message-State: AOJu0Yw5WxWQA+MugVl3ZECON3rgWN1E5lNj9ej7wFastNXoAA78Se1B
	TeaulhzWCtkkWLxiCDnbupgNwipMkF3EPqOhy2JIdM46n0Z9sg/hLi7nkGhOIk9KOjwVApoMlgV
	18rGlRwZUYt0Dqj8dqSPUunJjUTI=
X-Gm-Gg: ASbGnctAkHriniAzMVrfGfFmvVMlPyVY80d/IFGfIlpswVTnZXziaUod9Kz04G8ppmQ
	XKKeEO00gKokjjSyTH9XyTi3SR+BrkAfsnaE=
X-Google-Smtp-Source: AGHT+IGZsjUHNHgZScctt9GhUUISo0b3ncG99pwHqmoX8StIWNsTQgzRKfAm5Fp0Di2hDokmvL3agPwZ+93jj5g8oTU=
X-Received: by 2002:a05:6e02:1ca7:b0:3a7:6e34:9219 with SMTP id
 e9e14a558f8ab-3a811db26admr175649315ab.14.1733841056498; Tue, 10 Dec 2024
 06:30:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241028213146.238941-1-robdclark@gmail.com> <20241210111450.GA14735@willie-the-truck>
In-Reply-To: <20241210111450.GA14735@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 10 Dec 2024 06:30:44 -0800
Message-ID: <CAF6AEGs72rxvguSYbALWPL2FrO5coyijQXY4HEQdwvr8Fj4XKQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/4] io-pgtable-arm + drm/msm: Extend iova fault debugging
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Robin Murphy <robin.murphy@arm.com>, 
	Mostafa Saleh <smostafa@google.com>, Rob Clark <robdclark@chromium.org>, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <dri-devel@lists.freedesktop.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Joao Martins <joao.m.martins@oracle.com>, Joerg Roedel <jroedel@suse.de>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sean Paul <sean@poorly.run>, Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 3:14=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> Hi Rob,
>
> On Mon, Oct 28, 2024 at 02:31:36PM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > This series extends io-pgtable-arm with a method to retrieve the page
> > table entries traversed in the process of address translation, and then
> > beefs up drm/msm gpu devcore dump to include this (and additional info)
> > in the devcore dump.
> >
> > This is a respin of https://patchwork.freedesktop.org/series/94968/
> > (minus a patch that was already merged)
> >
> > v2:  Fix an armv7/32b build error in the last patch
> > v3:  Incorperate Will Deacon's suggestion to make the interface
> >      callback based.
> > v4:  Actually wire up the callback
> > v5:  Drop the callback approach
> > v6:  Make walk-data struct pgtable specific and rename
> >      io_pgtable_walk_data to arm_lpae_io_pgtable_walk_data
> > v7:  Re-use the pgtable walker added for arm_lpae_read_and_clear_dirty(=
)
> > v8:  Pass pte pointer to callback so it can modify the actual pte
> > v9:  Fix selftests_running case
> > v10: Call visit cb for all nodes traversed, leave the decision about
> >      whether to care about non-leaf nodes to the callback
>
> Do you plan to respin this? I see Mostafa left a proposal on patch 3.

Yeah, his suggestion looked reasonable.  I'll try to get back to this
patchset today.

BR,
-R
