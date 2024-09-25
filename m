Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5867CD520
	for <iommu@lists.linux.dev>; Wed, 25 Sep 2024 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727288025; cv=none; b=tqZu7q4emtavkYfM2laJePMuQ08hbb+hprV1+MXUW0BJcFEwvriw+YP5n3XLuZQXPWjUqoG7zXy6twsSiWbJLDf1qY/JIi0vLqTzQqX/sUh167Gojda7if5os+gWGxKJlgzWx7YHTIEgHYllSRVpaSAEHUKlsG9nPGSs6MsXZ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727288025; c=relaxed/simple;
	bh=JQYy6ttU/i/3yQtBNgzux6kaztcTklj0IHJQHcFlP84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcHR6kclF0DbMqGjoTInVUbrfDufyGTAJNbL9mhObFHWpk0hxI/5bvo9s/lboaB/RxNjKWcDCwvG8upq5ryzewooMOqHKWC7iDVl2nt6B3MvN8N2uTEt+swtwV7luivyZy+Upf8Ol4cschuFTl0QBP3ueTpAWK23eRvOrM7mRS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W3q0BoFa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3q0BoFa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727288023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9ajmmr6XMjVjBJtF0Yo2GlyD0kiwIhRSnbtBKem+rA=;
	b=W3q0BoFam+w9tXEm+zWv3rfgQEyCdBhcekV4PooWCE+0Fo4ZvCB/y3fIdYcaL1aglrU1U0
	5wjIjx/IE4Ihp+hc6el81Xp+3LwI0fnRHIj77SAd5cZgCZ1NAXpDd9Wb9YRgYf2qUS/9d1
	J4GYjA92eHj0C6hdHcIHk60GDL1hAYk=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-e2BBaVnnM4Oh_KHY6z4w_g-1; Wed, 25 Sep 2024 14:13:41 -0400
X-MC-Unique: e2BBaVnnM4Oh_KHY6z4w_g-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6ddbcc96984so2773237b3.2
        for <iommu@lists.linux.dev>; Wed, 25 Sep 2024 11:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727288021; x=1727892821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9ajmmr6XMjVjBJtF0Yo2GlyD0kiwIhRSnbtBKem+rA=;
        b=pdsbVVjQn7UYn+UOOne5ko3GshRh2MCjpKJmbpGt9PxfE3zI9u2kARG0lDWz5WqUfy
         bEQhNzN1G09YX21iVp3pdHtdbimMMb8IfT3Nt3EX3b2/sj5dHsOZqNEGqunIPfbtczTv
         P+1BWmP4VnLfCA4mUUKiLx4lrsLGVwfwWZUTm9c/FzBwnN4HpU8Fjfk/pJP6NfqOs16I
         icvYDTYGpSn/rDYS78+id5VMLIKEmkjHqJ100GXZ1makNCa6XYRnXunjI/5ShO0uYipV
         l9vYLAq8n7dALSS1BwBmsGoYrkAx2+XTuNeAR0nC8GZdSxS7LPUTIwg7RN1Tq0SNIZYk
         QicQ==
X-Forwarded-Encrypted: i=1; AJvYcCXylodvwxYEClLaV8vwK6ziFcvoijdTv7aiZ6aeuh+IRQ4VGia0p5BMCvGcCL6IYPFDz5WxCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVIcTqmYjvytNTF3Ehe+HjXcU2xBzNCb7LNDzrMBWznD6vkqW4
	3bUI/akSM66ezFxhlP8tQ1D7Y1bT0d5xjZ+4Xi6vRE6omPOHOX6bu5ngeb/Gp3yKLZz53WQa/CN
	cMIyF2sOje0LMY00qkqEQ6SJBED3Aul0qEfsAhiOElmYBNXkMaPv7ncmR8CtS8nbDAHhbPMUuyK
	GRh/gFWt9uJE6EfNhqjinI54NXvVc=
X-Received: by 2002:a05:690c:64c3:b0:6ad:f6ae:7685 with SMTP id 00721157ae682-6e21d838678mr34530077b3.20.1727288021382;
        Wed, 25 Sep 2024 11:13:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3dklGZZYoRlZu5kkgzc2LFblYFn21ln7HRQP0rqBowfCP/18/rjMGTRzXCUEQmLf+LbZHcJCboLxJHRn5o3I=
X-Received: by 2002:a05:690c:64c3:b0:6ad:f6ae:7685 with SMTP id
 00721157ae682-6e21d838678mr34529767b3.20.1727288021053; Wed, 25 Sep 2024
 11:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240919165641.4632-1-user@am64> <20240924020824.6264-1-user@am64>
 <8eb45005-c6fb-4baa-a44a-243958a3a1ba@suse.de> <c960dc48-0a05-4cad-b86b-33ad59923bc3@suse.de>
 <CADnq5_OtdUvOUPpq1aUoxtgpt6a4h598019SNhe+9ZWUaANYqg@mail.gmail.com> <CAGtn9rmUfHHOGX-_7ZNUpJMjBkCOMaAuGQsJnpSrfjMfmK1xSQ@mail.gmail.com>
In-Reply-To: <CAGtn9rmUfHHOGX-_7ZNUpJMjBkCOMaAuGQsJnpSrfjMfmK1xSQ@mail.gmail.com>
From: Ewan Milne <emilne@redhat.com>
Date: Wed, 25 Sep 2024 14:13:29 -0400
Message-ID: <CAGtn9rnd1L7PbWs6K6vtB2hC_vX3qC3XNudJSt=X+VNd7q7-kQ@mail.gmail.com>
Subject: Re: radeon ARUBA NULL pointer dereference
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Arthur Marsh <arthur.marsh@internode.on.net>, 
	Xinhui.Pan@amd.com, airlied@gmail.com, alexander.deucher@amd.com, 
	amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	wuhoipok@gmail.com, iommu@lists.linux.dev, 
	"the arch/x86 maintainers" <x86@kernel.org>, Nilesh Javali <njavali@marvell.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Follow-up, qla2xxx appears to be fixed, most recent test was with:

commit 684a64bf32b6e488004e0ad7f0d7e922798f65b6 (HEAD -> master,
origin/master, origin/HEAD)
Merge: f7fccaa77271 68898131d2df
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Sep 24 15:44:18 2024 -0700

    Merge tag 'nfs-for-6.12-1' of
git://git.linux-nfs.org/projects/anna/linux-nfs

I suppose the most likely fix was probably this one but I do not have
the HW to verify
(report I got was on an AMD EPYC 7262):

commit b348b6d17fd1d5d89b86db602f02bea54a754bd8
Author: Leon Romanovsky <leon@kernel.org>
Date:   Sun Sep 22 21:09:48 2024 +0300

    dma-mapping: report unlimited DMA addressing in IOMMU DMA path

-Ewan

On Tue, Sep 24, 2024 at 3:30=E2=80=AFPM Ewan Milne <emilne@redhat.com> wrot=
e:
>
> I think we are seeing a similar problem w/qla2xxx panicing at boot:
>

