Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0905695
	for <iommu@lists.linux.dev>; Tue, 18 Jun 2024 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673302; cv=none; b=jFIspjekifWL3DFZrWHTI3SF/VcWQgkkoPkPN9747oPE9dpulSZRiqno+7nd7JN+t3MvGMEzXh0mYVORjLlFYwB8SyqgfRADzqtwV1EVvHGTJnHjelV1S8bZ/SYOpkW8GwuZUnzWaNHYECDnA+5Ld+C1HTdCkvSocc6OytolFu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673302; c=relaxed/simple;
	bh=a7Mw9balXkdXrpGP42GBrIywjp+7pg5Y/72fbcj8y6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmdwX8nm6Z23vwgMB+C/JWlNLKMBTtBU7E0Q6Xdc93sDm+DnZTtEAR1xHJO6WsiAGA+HI2RO68a4O64uIinZ4RLgQdynxkwsk85cu2AXK27MLMajAaWABN8K8pfzovxn50RDIQ8KOzu7ctqTq7q063thtzKzcJaIAbYlJMa9JAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GRLWSic0; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GRLWSic0"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7ec2d71059dso87072339f.2
        for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 18:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718673300; x=1719278100; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7Mw9balXkdXrpGP42GBrIywjp+7pg5Y/72fbcj8y6A=;
        b=GRLWSic0M4ktUvJzqagr7LLRrjNUuhHEzjKhKg5AV6PS3IgJL5U++6/QRmrhviKR+X
         xfckGVR3uY1fD9Va9QJBmPDREo739627QmcpxuaO3cXcZtX/LKFAFHqD1ZbscRg0/djQ
         Eu/tWFEBlGDDsfpzBPps1XeT8wSBT2UUSPTaTlbLqF5ASorroBfMnqtSjQvQ1br521e3
         k6WHJFIXpMU4/8K0uerATfE4OJiz6fX7Zo+iohgda46u9fiKtVW82ioAxFI8Q6SNIrK3
         Am2sAG39YngvirSCoh8Lid8b+wBNzOU56obWnPDMtEukv4t+pEo8zoW8vpsz5FzhYRvQ
         bnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718673300; x=1719278100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7Mw9balXkdXrpGP42GBrIywjp+7pg5Y/72fbcj8y6A=;
        b=dU3sUHhBznhmXPmsd5ehitDN3Pex7XSDa/g4+BmaxIK+KJUdoVFfQHbWFgvz3OcCxI
         rxnJx26ubRiEo4LOwy2OwHTSWSo3rUmZhCDuhGTZA754Z/UzjL8wprW2wqlBs2fwHqU4
         I5o/YpmP0LCoDTG2UKGP597ML8IU6eDyfxaabSMgbAAEJSDzyKlyREadgTPLvI1QbBtl
         TF3ysVEQl8I+pML9gyM5Y6Saan6I/e8AmwFw5KpQXrdMs4sVEPoqyLLjE5B+YACzxeu5
         27r2Fy423FqCzqkhowk1+nXZCCs73BGUg4SUQ5YFoIL9RF3vKo0HPaum9t3KnHHuE9SP
         BrNw==
X-Forwarded-Encrypted: i=1; AJvYcCXCxqmEbLN7hY6J5tgZrkHkce65+SZPPOg8Q0ErvVGBuuiflJvo7O3DvcriCL5Zv+wGtnyuZqBkBcF0g/YiPWMo9NWOAx0=
X-Gm-Message-State: AOJu0Yy0tSn1ysKf99fNyf9K6Qh6FF9ajJV0x/cvaK7U0vACjvEi5jht
	Z4ELFIL63c4Z9l465hJC6SRV4gJcdceLDv1O/l/uN4gUHdCuWAtwFJ1jbhdTt4LWAHLaBvb8ejs
	R2LuFrqkL6zE2xI0hHvCdSdwQK4acvAbFulVgNA==
X-Google-Smtp-Source: AGHT+IHVk2V/zxfCC+TEYjE1GLUfJe8wd2/UBNvu0XGLc1b3cPwbgU0WKTC0+y5CcD6xobj4+R6Bbm6kIWf56tesqFQ=
X-Received: by 2002:a05:6602:2dc8:b0:7eb:7df7:461c with SMTP id
 ca18e2360f4ac-7ebeb644d32mr1162260739f.21.1718673300529; Mon, 17 Jun 2024
 18:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-2-zong.li@sifive.com>
 <20240617145521.GE791043@ziepe.ca>
In-Reply-To: <20240617145521.GE791043@ziepe.ca>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 18 Jun 2024 09:14:49 +0800
Message-ID: <CANXhq0oq=JjwjneJ+S2YtuaaPWdHYHuKrtcm+_Agn4CfjbyfDw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/10] iommu/riscv: add RISC-V IOMMU PMU support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kevin.tian@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 10:55=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Fri, Jun 14, 2024 at 10:21:47PM +0800, Zong Li wrote:
> > This patch implements the RISC-V IOMMU hardware performance monitor, it
> > includes the counting ans sampling mode.
> >
> > Specification doesn't define the event ID for counting the number of
> > clock cycles, there is no associated iohpmevt0. But we need an event fo=
r
> > counting cycle in perf, reserve the maximum number of event ID for it n=
ow.
>
> Why is this part of the nesting series?

As you mentioned, it should be a separate patch set, let me submit it
individually in the next version. Thanks

>
> Jason
