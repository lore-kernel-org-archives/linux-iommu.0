Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E352E54763
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777008284; cv=pass; b=VcQn9HXEb3wxvlnH6SH6DdUcX7E/t+/CPJvI/wa7lSYoNGXhXyDN8ccazYMDYc7vf46zU2YWgnG/bNg3kWOmb+OfNs+YmgPJ54qbz/PqNcf/8R1F9DvBy1vHJDNZhRPAQ7t049NOJVNylQklxTaCuEKH+gWeaeaYyYAK4LsuuAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777008284; c=relaxed/simple;
	bh=VRACvC8V0IA/z13RY36KW3WfE8oTCOLSp4Y7OLD6NQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcqyMGkNFg2bdKCZ9k5sENIF5zi1ya3ncICDW7zoUkzfwLhWWyL/Ir8OWGaeaizoJS/RMLwq1XbnC+Kox/kXYJ4GEnE8FtrhJSFwbbdm+8hYoxFNDJoAyNmrim7WKgfTnQwV4C/CcNNguKTXoIZkQyK4/NjLg/ypagyNNH/9sH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eq5h/wNH; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eq5h/wNH"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50e61648f10so3843751cf.1
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 22:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777008282; cv=none;
        d=google.com; s=arc-20240605;
        b=ILBH8X+ENw+TxuaP2mKoG0/pet1zhKi3meZiEN7QLT2OJEWopsQlEgam9vM3pJdyqb
         W7wH/QSJXFjyC5xMSzfCNzxyAYEgYCCiGwkVYA2x8xcydI/IFmA0f354uAe+cdQXsQlx
         /ieKR/fpyGsb9jhxRAZa6EJoMU5URAK3/jdUI2gI02QtafdnjOOwWntNEj4tWba0OF7q
         HdZlCB4URbjqgtP/fwzdSa84Jp/u5XJNyNgHs8ZcT2PFg4azlgoY9aBKmSpv1J+YvLkq
         jOeAxSg7pMrcXKbB4FLPc9cHz4PXv5DnN3fzzDhaEQbExkdZN/0+8Sykf6pk8HU8Pae4
         zeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6dqKQZkReppotzj0TnvlXoSoLn5wY2nwC0/akC2q2hU=;
        fh=l6d/N6u1hLHPo4TGqiX7B6XhUFrf2YjgyiVnG6QkPqQ=;
        b=XT91p8kn/DU6swxSDzqLSwPUyf89yf+nRLGoYJlplKrUw1M1L1Bp+3SKzD0MPeYFgA
         p7BlJcLS7h4756i4Mai8vfa3pIfUcCGEraNrdrNRSE5aSIzfu2Cgc8Za+Uzpj5Z1dEoX
         m7ZvT7MC5srrbL48MlShc2d4ajuGkk9tll36cZ+w2dGvMvjYXu5XQwna3WeXtRf4bYBz
         8zBbaUddXzijn32N7lkruynQhlRATGZtqT1ChK2+q5GSrL6cqKL3wJA0QeDeLu0TOPD0
         D0LSFDtkJhR8XxcmgLLzx1wqPFCc4JCYLFkQqIQ0Obs8y+mPhtoSUu/6HsAo8UHK9Ntu
         SQ5g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777008282; x=1777613082; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dqKQZkReppotzj0TnvlXoSoLn5wY2nwC0/akC2q2hU=;
        b=Eq5h/wNHdQ4DLonYQ12vRyEUx90zZxDJoFIvQyYFVQsDiINSK4f1FCIHJG2zNDbFHl
         Et+Ycc/pO8sG8XSAaagPEzCp2t2zXVJryJn1lrlGhMvDkO1bf0AEYmNc+EqW4Pv5pick
         xaJkzKAZbzNS3Le3xOvH2EsYCAvgbMSHEMRa2EpuDuf7rFMz1FV8SCQ7cLMizxEagn8M
         raAclxosmgrYuM3wXeLGXgv2vnRXLDzogNZN/LhmeJz/09m+CZHWhr84Wf4oOOl/d4Zl
         kLMKA+qbzEQqDdzk9zp90u3MYfxwWszjvF2tydmzctWlibUkvFw2TEzc68gE+ZX82MQP
         7iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777008282; x=1777613082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6dqKQZkReppotzj0TnvlXoSoLn5wY2nwC0/akC2q2hU=;
        b=LblX6gQu/3iknpBQNxUjbWrrmGGOuJmLZYvW3PxJSGhFD2ZA7VQtEeCI2alxz4ATyS
         UkUn7gkbOCLYPnFs9Fjn/aSe0U2+C2cHZnYUIRsVsaJRk4hhFTbjRcg9HzWNr5WM+5Sh
         a4+GzoS1X+KZbTMSmZORiYQIDdXo0pDXK4d/9C0mVEFcsZatwe5SQUNHwi0tRQNsHuyh
         SOsFGHETDL6hdq8mAEaa9JtFyFzDnSDgx/UDK9xM5oekZ/XDSP7qNnW/noljp//1EHNI
         OCeOnJK/96ZY/eyhPr24c787arAzwwXWz2dGUzj3MY0grBqfSFr/67mAswFaf2ofDOGQ
         4keA==
X-Gm-Message-State: AOJu0YybTXoGb0SzG6yY6YP4skQBJwdwa60Qc5ifAtKzBu4m6ChKfLYf
	ic7sHxdXWEGzcqcUAYpryWw5svjfMLgaXgKKUERNAaKZNhS+FZJcsclhJsCnbTbdxPuDw/14VJe
	OoY+j0ascEIBXGeKusxERh4Wwh8i/FusAi2A5g/CS
X-Gm-Gg: AeBDieuV2hypiJPxQifoMLhybl6je7/N0tF6QXww2NEwkCIwcfakIAfrTAQvehWfRqb
	8rz2Twklpqi4psY6AfMgECL/YRSicpL6n4D055QnRHafJK77GA5OPwlWlQWXQrA0crI/GFbJJYF
	QHvc2tOx6hOMw83upgFRmEkVuWQZ6Ay1hN2OjcPgJ+wNUM21x9DDdBw6wSexZMlpSymna4dtps4
	PbLqVRoCk+IGUi4jW4OIvB8vVHI8SXiNQKqkb6hfeiYdNLMZFbxNsFfB7XyuWTL7Hirz82DcuS6
	TDumaQ2/I5ZWb+v8BJelCaxoxw==
X-Received: by 2002:a05:622a:188f:b0:50d:edb1:6bd1 with SMTP id
 d75a77b69052e-50e441b443dmr56101311cf.13.1777008281555; Thu, 23 Apr 2026
 22:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260414194702.1229094-1-praan@google.com> <20260414194702.1229094-8-praan@google.com>
 <CAE2F3rCaBWtRruBbZcedrsLnkkETSniTWoxxYn+Lkac9ttsshQ@mail.gmail.com> <aejP5Yk72_FtZnIo@google.com>
In-Reply-To: <aejP5Yk72_FtZnIo@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Thu, 23 Apr 2026 22:24:30 -0700
X-Gm-Features: AQROBzAotIitKn8k1E8FKRYqUkUTIhwhImqFHUUwcssEnC2zye8DzVR4EQ9M-HI
Message-ID: <CAE2F3rBeqrTkgqwYcY7SPiUaPap6y8Hj95T0KqWCnaG59VB_hw@mail.gmail.com>
Subject: Re: [PATCH v6 07/10] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 6:41=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
> > > +       /* Clear the STOP FLAG to allow CMDQ Submissions */
> >
> > Clearing the STOP flag here seems premature. I propose the following se=
quence:
> >
> > * Set up command queue (SMMU_CR1, SMMU_CMDQ_BASE etc.)
> > * Enable command queue
> > * Clear STOP flag
> > * Enable SMMU
> >
> > By clearing the STOP flag, you allow arm_smmu_cmdq_issue_cmdlist() to
> > write to SMMU_CMDQ_PROD which then races against
> > arm_smmu_device_reset() which also writes to SMMU_CMDQ_PROD.
> >
>
> I agree, IIUC you're suggesting to clear the stop flag before the
> TLBI_ALL and CFGI_ALL commands are issued by device_reset? We'll need
> to clear the flag before device_reset issues the  TLBI_ALL AND CFGI_ALL.
> Thus the sequence should be:
>
> * Set up CMDQ
> * Enable CMDQ
> * Clear STOP flag
> * Issue TLBI_ALL + CFGI_ALL
> * Enable SMMU
>
> Right?

Yes
