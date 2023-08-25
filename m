Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83122595
	for <iommu@lists.linux.dev>; Fri, 25 Aug 2023 09:00:18 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-52a069edca6so1071440a12.3
        for <iommu@lists.linux.dev>; Fri, 25 Aug 2023 02:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692954017; x=1693558817;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hpc1vqljg85MUjeJOJ6PgDd/3ZHlKeorKaEBJ/71mxI=;
        b=TeJsZTKtBOCZabq5H6IIOcnpMwGsBCdwR1TjRCneoAsoEkk/5w11XRXD6hfxjm8Ucv
         1VRp1yW0kXq0jiuwqyZKZaL12tbZjx8yLv56m3Fvg4fmSq47rbiD0TGEYEzjqfbVjpCp
         A7A+qk9xyJsBzHnoxeHd3zKp/fu32jMh7UvAsIhh38oxeNMaEH28ISc3SIrgP16u0Tzg
         kBJVe7w7kT1D9PXX8Gx+cn7u+C0bq6AxFR1woUDCTmP7qPnqnokyYzaf2OwZJpe8CWAA
         MP1xIk8eJ5l/Yt/Wv6veghzMpF4n25s9yXipxiyEsvJ0oYn96ycnkJXMR7LoEj2Y2M6v
         rGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692954017; x=1693558817;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hpc1vqljg85MUjeJOJ6PgDd/3ZHlKeorKaEBJ/71mxI=;
        b=W4R3yAn5Ss4KUybvQf38XPRljmzt9Z8VFgwj8CbG2AmviM9X7+YPHdkOYCkpGVu7Mm
         ib6zfrkMmG2NFhBYvulameVBzfciJsElS9W/3FXLw/NOQiy085yp72yhRaV1cIRw2VOy
         nH7P5n8uhp/GYR71CNw+PqOpkUc7D9dL+KKZRZtjcrFgyp+zuyiakp1rNfRa/lv4BthU
         MUNV0NvU8c/L1AS5zgvwZRxATQ2jP2m8FeYMtE1Dfz7oFdFFmtD0UIkhOhc63aMVkPAJ
         WaAxwlUM2nU9onEYwlhz95OCxiV2dbiLXLebHXnP1so4tSnArReWsYQAy47HRcvM699m
         50cA==
X-Gm-Message-State: AOJu0YzMT4sidBl7mDFn3N4ruNRPxwPfbKGsyD/WyqOoGcm0j9Fwgcm4
	mFrZ+scAsV4XR5lOcTD0OLk=
X-Google-Smtp-Source: AGHT+IHSg+Y/a+ZSWRCaIBI8ur+pB0UMM3A7cRqrSLufJqyoRVpXnGmKq5Hc45cH8/oYY88fzSORRA==
X-Received: by 2002:a17:906:af65:b0:992:7295:61c9 with SMTP id os5-20020a170906af6500b00992729561c9mr13810195ejb.69.1692954016379;
        Fri, 25 Aug 2023 02:00:16 -0700 (PDT)
Received: from ?IPv6:2001:718:1:5::ffff:81f6? ([2001:718:1:5::ffff:81f6])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906361600b0099cadcf13cesm725888ejb.66.2023.08.25.02.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 02:00:15 -0700 (PDT)
Message-ID: <aea2f9d25d94438dd60924c1e068bb93c0823a9b.camel@gmail.com>
Subject: Re: Thinkpad T14s Gen 3 (AMD): Fingerprint reader stops working
 with disabled IOMMU
From: Pavel Valach <valach.pavel@gmail.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, =?ISO-8859-1?Q?J=F6rg?= Roedel
	 <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Mark Pearson <markpearson@lenovo.com>, Mario Limonciello
	 <mario.limonciello@amd.com>, iommu@lists.linux.dev
Date: Fri, 25 Aug 2023 11:00:14 +0200
In-Reply-To: <e424716f-1290-4434-9e37-ed0c6a264dfd@molgen.mpg.de>
References: <7aa5c5f2-b60c-4aba-b03c-45c5d2672194@molgen.mpg.de>
	 <e424716f-1290-4434-9e37-ed0c6a264dfd@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

It felt really strange so I have tested it once more...

The fingerprint reader in fact works with IOMMU off just fine. Turning
it off and on has made no difference.

For some reason, the fingerprints just got wiped off,
which could have very well been because of the Windows install I did
to debug an unrelated issue.


Sorry for the false alarm.

Best,
Pavel Valach

Paul Menzel p=C3=AD=C5=A1e v P=C3=A1 25. 08. 2023 v 10:49 +0200:
> [Fix list address to iommu@lists.linux.dev]
>=20
> Am 25.08.23 um 10:25 schrieb Paul Menzel:
> > Dear Linux folks,
> >=20
> >=20
> > No idea where to report this to. In the Mesa issue tracker, Pavel
> > Valach=20
> > reports [1]:
> >=20
> > > On my Thinkpad T14s Gen 3 (AMD), the Goodix fingerprint reader
> > > (27c6:6594) stopped working under Linux since I disabled IOMMU
> > > via
> > > kernel command line args. I'll try the pgtbl_v2.
> >=20
> > Pavel, would you be so kind to attach the Linux logs with IOMMU
> > enabled=20
> > and working fingerprint reader and one with disabled IOMMU?
> >=20
> >=20
> > Kind regards,
> >=20
> > Paul
> >=20
> >=20
> > [1]:
> > https://gitlab.freedesktop.org/mesa/mesa/-/issues/8044#note_2058621

