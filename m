Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE0940F8E0
	for <iommu@lists.linux.dev>; Fri,  1 May 2026 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659956; cv=pass; b=eN6pW7PpxdL6HH4Qo3ApY/ISJsxwzhngyz1gTzdIaJfxpLuQERQQPC7uksD5MJymfl6UTmKlH7iaT9RQ2qSvjAlxouDkpKCbjZGhxQO4kUpBMZCWBq1VgYmWpt2dhidNmOh/Ksri19JaB8NuikdoFhTpIW162MvoE7CQoBC+HQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659956; c=relaxed/simple;
	bh=7glQpGGcTAa1D+c5BdpA3vyeZj9yXvwRLKoRKqlblRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzr7kERzpezGHOrY8o+GbC6oQl7nSAeWOan8h4uyKM/RZGP5zVXI3pQdmYcNf1a8xTFg0umd+2AJ8j0px+NWhE8AwSnjUQSuypPcdqmiz7lddDJaVp/7T27cQN+jAtgqBgzQU+CisRci1+eU0perqDBFMjdW5HKcpaxZPRWoSAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AyzGBO2P; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AyzGBO2P"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c726ef332so3485901c88.1
        for <iommu@lists.linux.dev>; Fri, 01 May 2026 11:25:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777659954; cv=none;
        d=google.com; s=arc-20240605;
        b=CYLmsqYPpb3VAKjCd1d0XkU/19CYw1fya6tuablA+FRWutakGrDs8+T/DlhoJpaPKD
         hvM51JC8MjTKHV6a/J/TnB3oOwM3Z0YnBJ8b2Q1RVwtjk41gJV9ZVxvi7uAdxKQUMppX
         xg04Ig1aArNFnAlqDV00z08xP8u/9/8rqgTtr/REkRPuv4Y4ti20Uo2WPdSrKilq8Zlx
         Ylhd0/qPlboC//65jzPNmsKRQWtm3I0b+sf9jvVVYjzeFz9ZTzlG+0eRqEyxY0f9bkN2
         5uEIpQ2raJTJcQX5nOqkSl/d/OCcQLQUJl1rwQ4T8aWIkAAtSLuTY6uKnS5G2PhA01g3
         YpLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ynp4A/JaH22lvkihT3nPFtsXKnzutYHpfXYULBKQQKo=;
        fh=I926+arf7AW+J2jpO4S7zDk+kQlcBMJLizH2QZxxKt0=;
        b=iJHM2DwYMD/I4lHv1HHwCXyiexvLjArbCeZqYFH9BzZ10081UxBWHjN2Z7My4eNQi+
         MkZBnTZaqjKfAvA0n70NBtpq8tL5qUD4WgiYOJ6PER9B8lQhFu6dfm/2vyaRJ2eP/tg/
         FW/iPEnwtGlL9OIvcpdNvqLeWnJEAE5frsZNbS4EslUn8F5bVZiRyFx69DYYwg37feCA
         OMAc2Va5f1+siaFKVdpXF9beZ/I14OT8Mc35dtIBiR423F+6+crhPs2NactMV26kPiRG
         cSyzo5CW2HIWZhlTAwxdY/1ZZVYQ0NET8Mv1GqtQUeghhWGXVON2684aDfwvPnfX0yGm
         /CLQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777659954; x=1778264754; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ynp4A/JaH22lvkihT3nPFtsXKnzutYHpfXYULBKQQKo=;
        b=AyzGBO2PRgG2pnl3Yj9cFiz1HUu90ywRvzQOXV1TKvR5udAzPW25oMxQsyF7Ircj6W
         jCC+9pf8PA/88uO8JQKsCZ4/nQaECOgQQIMzZFO5QcXJbO5bIVc6PKUhH7/QPcUDL2OG
         sk5lW3E8kNPpiuL/su6mut6Ao/R5RlExw80Aj1s8ZBk+R+JR55RDl3xdTOgIBUWTeamn
         EGLmM977AUl6tR8lgmqvzzkQrLoRJZZ3jIhst42JsLgZ5OsAu5KseVjFY+MK0etuYTo/
         YhEnOtES3bvAZ+O85Mfo18DwkOIf29aoBFRqHnSzEMRZferAlR1Uvymvad5UYpazhR/E
         k1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659954; x=1778264754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ynp4A/JaH22lvkihT3nPFtsXKnzutYHpfXYULBKQQKo=;
        b=oFjxwUMvb/6oLAT1Rc0a3Y1gSjBosTWamOTCnn6G8oUxhEm/qrskvDTef9vf0FIGBy
         iFGmdYq9TSd8sPxEGfU9uh3701prFpMNyI07A2ogfn+UgPDZfjAROBvY8kF5fyTYdoqE
         1sysnY2TKOj++vie8hYK1HTMva1ccEtYPqcUWI/nJpAFsgi4sFMQDR3Un1mtpGAuWD06
         PzdZKgz9If0BqsCjVPHCTVx+Tpe7Uj2pnMmPrjUbfgMcXPdOa7c1oa7CRpjFUAEbLvwT
         oRmxmcD8pT1QKcK3pVezUrZ7U10XETeEERCFxHNYhdBa8KQZv9Oj6k8fo3xhU7RriaKF
         XPGA==
X-Gm-Message-State: AOJu0YzCNOt8KBibDhFMa3k8TlY+n/xcw3vmSxjBZscctZHDwe2lDPub
	C+0ECdOKTldvNo4uK6HSUoJp97UOOmWglGpHbHg43vWWb2lYKzj33TLBLajFs9XOwY031OJ894N
	qEOYo5+h1wRqdj7mhwBkN75SpfFsEWOkw5QSRHlm0
X-Gm-Gg: AeBDiesOznzxneXUnEBhjjpCyiPSEeIEIglnWfwGAKpUI5ZHHdFpBlfSBEnKT0uf/Xb
	AmJYMZpsWsgmeGJ77CmE1k9lU7sfTW0ydH8HoGkuDIeXI6z1tT5BazyXVn59dC5xOC8+XKnHumO
	slH0G2WyCa9VoCjspn6Cdl1avzwBpd0JvHfP/c668HG1Uot1NRfraGTBanFfsaT6Jk7hlfeOASx
	x8/BDehfgupZn/hrvEPrshVCr31I7eoMKZ7x3D7bECkYJ7PG8MF4wYVwno/m3Izw2tQ+0EhcZR1
	CW352Au6xf7DHBLhJ/sPtnWzDBamAw==
X-Received: by 2002:a05:7022:ebcc:b0:12b:ec15:69d3 with SMTP id
 a92af1059eb24-12dfd7d88femr150449c88.19.1777659953185; Fri, 01 May 2026
 11:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-3-dmatlack@google.com>
 <afDqs6oqWlhoVqMN@google.com> <afPGYp145FbrvURR@google.com> <afTgOXpUNWMapPAS@google.com>
In-Reply-To: <afTgOXpUNWMapPAS@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 1 May 2026 11:25:26 -0700
X-Gm-Features: AVHnY4LHOeLRxPaffc9oaSUdxPiYe323BsN3VXy59mO0tVvOtZ5BkXLT2WRxf9Q
Message-ID: <CALzav=cJLA3-gK=Ljfqf=YCPML60F=hM_teB67M_3PNCZE4T9w@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI devices
To: Samiullah Khawaja <skhawaja@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 11:17=E2=80=AFAM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> On Thu, Apr 30, 2026 at 09:15:14PM +0000, David Matlack wrote:
> >On 2026-04-28 05:24 PM, Samiullah Khawaja wrote:
> >> On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> >
> >> > +  for (i =3D 0; i < ser->max_nr_devices; i++) {
> >> > +          /*
> >> > +           * Start searching at index ser->nr_devices. This should =
result
> >> > +           * in a constant time search under expected conditions (d=
evices
> >> > +           * are not getting unpreserved).
> >> > +           */
> >> > +          int index =3D (ser->nr_devices + i) % ser->max_nr_devices=
;
> >> > +          struct pci_dev_ser *dev_ser =3D &ser->devices[index];
> >>
> >> nit: Maybe we can move this logic in a separate function as down the r=
oad
> >> when we expand this to add VFs and Hotpluggable devices, this might
> >> change significantly? It's good if it is self-contained.
> >
> >Did you mean to leave this comment on pci_flb_preserve() where it
> >decides how many devices to allocate room for?
>
> I was talking about this one, as I think depending on the scheme we take
> this might change significantly. Just a nit, you can ignore it.

It would depend on if userspace is doing a lot of unpreserving as
well... I'll see what I can do in v5.

> >
> >> > +static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pc=
i_dev *dev)
> >> > +{
> >> > +  return dev->liveupdate_outgoing;
> >> > +}
> >>
> >> Is this expected to be called under the outgoing lock?
> >
> >For now this API is only used during shutdown, at which point userspace
> >should have already been stopped so drivers should not be changing the
> >preservation status of an outgoing device. So I don't think this needs
> >to be under the outgoing lock, but it would be nice to have some more
> >explicit synchronization.
>
> Ok that makes sense. I have similar cases in my series, but maybe we can
> add kdoc regarding these stating in which context this is expected to be
> used?

Yes will do. I'll add some documentation and also restrict it to avoid
misuse (move to internal pci.h, return a bool instead of pointer, and
use READ_ONCE()).
