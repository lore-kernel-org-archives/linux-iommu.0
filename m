Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC35C433C8
	for <iommu@lists.linux.dev>; Wed, 27 Nov 2024 03:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732677927; cv=none; b=roILJWuKXxHRHy/dQbIyfNqi6KMnDSOmWLpojcJ7stZJOYoccg72I7CQeFOk+ET4AuvU3OXtCjQZLf8hi/eXvDC+9g2W4d2NJbakbNhkPxOFrzDG5Mw0gCRg4JRkDgmawDyuLAucjZF5GGpoc6tX47llk9acOEHv+KybgyxmP38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732677927; c=relaxed/simple;
	bh=BdWZAi+wyR284BV+8Kap7muuWbOIKN3YR6o8xwwEjFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKLVu75aloo+1MKRn9vhrwRoWp2eufFvu891FYawYsh8qoaZW04EJ8RFVcB/Wr3valew+mEMM/a9CJW7Qq5iquPCrVP6GkeojGLz0dm0xtcu+e9kCDofJaNZJxqrUmWo3U7GHRgk2/W3Z6fc+QvEL/PSbzFguAlP1sWSPz8UqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qg5m0cfZ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qg5m0cfZ"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cfb81a0af9so3132a12.0
        for <iommu@lists.linux.dev>; Tue, 26 Nov 2024 19:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732677924; x=1733282724; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EM9xpaSA1vlwDRjrxNyec+f/W+3OvChsFdPfArM6l2w=;
        b=Qg5m0cfZWXhi0WG1YGoNeFv9i2oJfkY2s0/pnG1MGJmpGWCb8agcv6+XWJwlXhn8mF
         GOPMETr8KVnxl/HQR0hMZ/fc5G7EzKdwaKg1MW6jqKoSaawm7HrcVlpSexVu/sErIuVX
         ImeUcpUjLpjleGRwyIlDu2vPXvqMTqBDWg+tYBxaCwDgJCFwk4RtUItMTGuqjHh+Qa1M
         fJmMwKXWEU/mdhqPYtID4E7FAappFarAYHk281wHc6JC2u39DGL9sQCWB3FIyOJT+VX5
         v0Uor/SnfhXbR17P7I1QpIKyyHTyPmSL7M7nj1yKxu6BviWLmF511jcUNVUOkqWVqOC9
         t2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732677924; x=1733282724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EM9xpaSA1vlwDRjrxNyec+f/W+3OvChsFdPfArM6l2w=;
        b=GPep0Uu/6vT7GhZwW42kRkZwpkZo3cIfZjnSCgklQVflklfiBkz9ml7JCREz4+Nkd5
         Gjgl0mvILru7OoUQd6gpizOITLBGS8QfrwlQTqtA05kag0flxX/9yflpXNngLg9GsqLJ
         0/twkuzCEdWdnTMa4TBienU79Zy3B0unYuMt9wijVRP7gGtVSmm16l0bg3FXFa13ijqy
         DJgvbFp9fyeHP/kHu4TgL53d3WMkCoqqApjYP71n8V040Wd9C3UXPZEGeTd7e4/w6aog
         7EbFhwfsVELw3mD2TSUeEPWPziol2XGa/E0rl5IV5TJyBagGfFpWeISXRKMUleyDBy22
         NBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt/tUpbhiops8vr+X6j7O0SWpNpup3gs82PwQ+wBwT0sDhha02P4wijQFZx70Pe3HfIMpOfw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXRB0bkcbXmhmEuJz4WGJqk4P0vYryQQNZtT285FtgbGp8pQNR
	7sfht565XOiiFPQ0+UNCKbuHbl8ugxCsLv8q4eYwFpH62W9VfYyuyKskTsutINidmmAODmlgwzX
	vLO0avYObiOq6YlL/MfqDfKjVqox46qpLcAql
X-Gm-Gg: ASbGnctVnpoh3XXusjLxN+KJuL33vmpJLZ6iqZwbq9RQJQXGQ6xqng9vgLfsoHCP5Jd
	5XyPzubA2KzOncuYs+AqhelGmFN+kCI8ZIyQM88+wldw3aIemXWbKahQlY796noQVAw==
X-Google-Smtp-Source: AGHT+IFJIUGILzEC4l7pV33Vt+hP++DXtcqywLeKOC8IzXS1FPWp0cx/nxIS2Ebmr2Y85aw4Nt1+t0jvwq67TxKIJRs=
X-Received: by 2002:a05:6402:26c5:b0:5d0:8723:487d with SMTP id
 4fb4d7f45d1cf-5d0872349cfmr97a12.5.1732677923631; Tue, 26 Nov 2024 19:25:23
 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241112083018.1662104-1-praan@google.com> <20241112083018.1662104-2-praan@google.com>
In-Reply-To: <20241112083018.1662104-2-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 26 Nov 2024 19:25:12 -0800
Message-ID: <CAE2F3rCO1PbzMEdJB1zRFK+FsbYa0w2TWrGL-XV6y9A9vrqytA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 12:30=E2=80=AFAM Pranjal Shrivastava <praan@google.=
com> wrote:
> +       event->stag =3D FIELD_GET(EVTQ_1_STAG, raw[1]);
> +       event->stall =3D raw[1] & EVTQ_1_STALL;

Any particular reason you're not using FIELD_GET on EVTQ_1_STALL like
in FIELD_GET(EVTQ_1_STALL, raw[1]); ?

> +       event->class =3D FIELD_GET(EVTQ_1_CLASS, raw[1]);
> +       event->iova =3D FIELD_GET(EVTQ_2_ADDR, raw[2]);
> +       event->ipa =3D raw[3];

Shouldn't this be

event->ipa =3DFIELD_GET(EVTQ_3_IPA, raw[3]);
