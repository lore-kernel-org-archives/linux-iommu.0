Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154CD43636D
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780476869; cv=pass; b=IBB5a/XDUmVf4T/5wI+GEjMfDUxpKCfZ6RgrmocSOplEe7S9AprMoMQ88kgCKzzBlu3Ga4gqP1miGidv+V/j/TdMewsbFzT//GxTzbCD7JN4gWTwq8K37S9ezFu54iXmQBxr9xS34kEi5wIUaIqgOBVeUWWKUuLIRt7Pqgo/k3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780476869; c=relaxed/simple;
	bh=LWdpnYx07T1Ms5zP1asG6Lruytmqf/Fa2t41ma/B4B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEV45eQLXt6/9EkZsoeHiy9kmKDreqwcs0UGHB97iHXs+2fs5dv3eCNeANw0REnCABbptSDtNB/7fUR0zNoxXaumOacbccmbeV3NWQ632C6nwu36bxoAhrnHKIDEQsfkGbkVboV7/2C7SybFQGp2FnYQ8rGDnQt5uXW3B5OpwqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b=BT6IxUkE; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b="BT6IxUkE"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-91588056619so75742985a.2
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 01:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780476865; cv=none;
        d=google.com; s=arc-20240605;
        b=I+XouqjJwkpwUyRVw2NtxNSvohrJhDpWwFc/p3RmRmCbSquYJSZKkDLm16caYvENqb
         MOosxVLx5MITksIjpo1TUOat96botjygI8CCgO2dllTznaiRX3qVwrg/BB5O0I7mLd+V
         V1o6BYb8y5HnA44W9Lza6HDIG/sT/EZL07oUxnQyIZdUznPR0jwI79Rt2Sg8LX9qCnA6
         OC9ysAd7GRNGHOzhZZlVd4tE1qws9pJ2ADTTcA7tsg+cZcNH+/v3/v/dRTgjkQhOnsmJ
         Jc1CHSD2YgB5LAzcbCAQgP/SIFXpMZuAZPMTklWBVV1/+U5bL249l/9bv5ydWhC2iomW
         Jruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g7JX48xUqE191PjwdvrWj7w+4oUCIR2hhRFUmFcQpEw=;
        fh=BtpaCGD1tTq/i/uZBzkXsh14TD90bzzku+9MDGhR5Po=;
        b=iA3saznr88AhTzLF0mV7OirsULhM2Y+dcXOeduaXx5bG5OvakpNNZ2Hd6p4I7QFWDF
         TYaVmHON51Lm0OrDfAZppRJI2A6kU1ma7DUDj9fbQkpVlRvD8lO5lGWkkB60cIFF/hUF
         f+zUkboQWKpQ3DCEz+t/Q7ILVH9Mplr3DDESZh8dmq4Uuk/Bc8GVVTUB0EwIDWkUtySP
         eBhSDiIFBUxiAty4l2NBqHsecbW97dFHZHI/JYtInTxy8KZkxgFjo9olpRNY317QZ5Qb
         AgxZF8Kc/zSD6q6eDqEEJXj6jU7ETsMhZ5nbWBk1Us+bgM1wkgf8PRUqk/q6l0Nr+Qq7
         deFw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20251104.gappssmtp.com; s=20251104; t=1780476865; x=1781081665; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7JX48xUqE191PjwdvrWj7w+4oUCIR2hhRFUmFcQpEw=;
        b=BT6IxUkEcyhnPHfAUrOzM2DJ6XFZpwAzzMUFbWfh0Iw29oqaN7cnSh28WriVIw4fP/
         9UXJSETfwGDuY1X/vhRHCpjaoeFsW7RHvwO4K7YsT6FemA8cR82+Sp6V1y6GSIc7p0/I
         ECOCUzNUmuV8BdpE/Ly7XDn92J0Me/aDT2dFTXsVDPLKMk/eKGHyyD76omHv6XSSPDJp
         yep5Ysz0XZJ2KC/E/p361ZUBpBXyJ1yYY7cAvIPyKwlKxI1w3vySObwxbE2Ny8wkmFFn
         IqvcyS+HEmz5TYp/wGt/YZAeLy14Y9ez12hbrGhKfKCWq8lbzDue2PgBqFhuJ2zytNea
         klmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780476865; x=1781081665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g7JX48xUqE191PjwdvrWj7w+4oUCIR2hhRFUmFcQpEw=;
        b=q8RGJmHNfRcV9lGPlhU6OBYYoqHraU6aSIFhzS7oBrvXS6kqMxZIBLLBU6bL8UvZdt
         ygk2T9ggWN77aOm4K2KEAJVVWSn1R8/ChT9oSGDH96eZEgXC/fjnBbG2h4knrbi2A5M0
         t7EuwF+YNXwpTh8TIzGwwPICYz4fNVa6qPvopS1KwzIYxUvjfxgsrvTlEJmSW9YOf6Iu
         0q+6WQRM2B2SnEAsBfDhLOW158RgX7AFfEQStjijzgoadhtA6b1x4wAYGpBjtMYqorWR
         Qbx9jsYo64UXGB3Lg7EpH9P/kFbv0+1nbHlNzK9QgL44AIkzspLUs8uZhze79oNiT6+L
         xg8g==
X-Forwarded-Encrypted: i=1; AFNElJ+eFbSXTdK35hXblrcczNExUxSxOWUZ+HpzDugEpDuKcMXmZ2uXToGY3x6rKuRLvfQsJ6EK2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRaxbEu8pWUTFNhj1ykYq96eKz9KoF7gpM1+VEIScaJgbsbetJ
	tYVGLaxwifRRdN648R7x9TnvdOH9II3pKX2QcJtmS4lSJTuWFzMu+szlBNE+4sC86nGo3FzwJnN
	lXuJ79qebOHJ7Jr1sdLS/mwYurDcWjEy58qOL6V2Icw==
X-Gm-Gg: Acq92OG2BW40FGDiiH3T70MvrgZc2yQZaEonc4+SYNbrIh1pWZRm5stj91eo5VNxuy9
	nLxdCR0duUR80zYTwDdBsD0rGuCebvAl6mGSeizlHftkJXiY2IXw9kcDq5SAxP74joELXnf+vmf
	gigF8lOnCMSHjR4f37913bqB5QQ5j6sl+nFxjm+HSf+CNRt0p8+46XrYa7zcCy9r224MHlimOWU
	6qpLTqvX3uDpKlEMCrrDOrOp6TQ65bQORVL+n1eujep/YiXqGw4VQ8otUlVgLVEla9lPS0o3VMO
	Yb0Oj0YQdBJLkBDy
X-Received: by 2002:a05:620a:470d:b0:914:e3dd:17fd with SMTP id
 af79cd13be357-9158a6cce06mr407596485a.6.1780476864872; Wed, 03 Jun 2026
 01:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-2-b2d984c297f8@oss.qualcomm.com> <paiohsil5pmvm7cf6jxrhaj2225bgvlt3scrag4x6gbkyosow5@l4tbakbnxcvo>
 <CAPsqS2Tt0JbHhJLHBsbJ2YfZW913WNfoSXpSa+8TD1T9CV8V3g@mail.gmail.com> <9879f670-8a23-407b-ab45-673904ad4a86@oss.qualcomm.com>
In-Reply-To: <9879f670-8a23-407b-ab45-673904ad4a86@oss.qualcomm.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Wed, 3 Jun 2026 10:54:13 +0200
X-Gm-Features: AVHnY4JxR71JOH6mKjWdwqMelPGIBYkdeP3ekd-6Gg14JWpiLQqO3KnjrrlcThc
Message-ID: <CAPsqS2R5kr1-UqhijjgAfU9D1VnyEd3pCxOagHyesHSHpN4_8g@mail.gmail.com>
Subject: Re: [PATCH 02/15] accel/qda: Add QDA driver documentation
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bharath Kumar <quic_bkumar@quicinc.com>, Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org, 
	andersson@kernel.org, konradybcio@kernel.org, robin.clark@oss.qualcomm.com, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 7:22=E2=80=AFAM Ekansh Gupta
<ekansh.gupta@oss.qualcomm.com> wrote:
>
> On 20-05-2026 21:17, Tomeu Vizoso wrote:
> > On Wed, May 20, 2026 at 4:12=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >>
> >> On Tue, May 19, 2026 at 11:45:52AM +0530, Ekansh Gupta via B4 Relay wr=
ote:
> >>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >>>
> >>> Add documentation for the Qualcomm DSP Accelerator (QDA) driver under
> >>> Documentation/accel/qda/. The documentation covers the driver
> >>> architecture, GEM-based buffer management, IOMMU context bank
> >>> isolation, and the RPMsg transport layer.
> >>>
> >>> The user-space API section describes the DRM IOCTLs for session
> >>> management, GEM buffer allocation, and remote procedure invocation vi=
a
> >>> the FastRPC protocol, along with a typical application lifecycle
> >>> example. Sections for dynamic debug and basic testing are also
> >>> included.
> >>>
> >>> Wire the new documentation into the Compute Accelerators index at
> >>> Documentation/accel/index.rst.
> >>>
> >>> Assisted-by: Claude:claude-4-6-sonnet
> >>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >>> ---
> >>>  Documentation/accel/index.rst     |   1 +
> >>>  Documentation/accel/qda/index.rst |  13 ++++
> >>>  Documentation/accel/qda/qda.rst   | 146 ++++++++++++++++++++++++++++=
++++++++++
> >>>  3 files changed, 160 insertions(+)

<snip>

> >>> +Usage Example
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +A typical lifecycle for a user-space application:
> >>> +
> >>> +1.  **Discovery**: Open ``/dev/accel/accel*`` and use
> >>> +    ``DRM_IOCTL_QDA_QUERY`` to identify the DSP domain served by tha=
t
> >>> +    device node.
> >>> +2.  **Initialization**: Call ``DRM_IOCTL_QDA_REMOTE_SESSION_CREATE``=
 to
> >>> +    establish a session and create a process context on the DSP.
> >>> +3.  **Memory**: Allocate buffers via ``DRM_IOCTL_QDA_GEM_CREATE`` or=
 import
> >>> +    DMA-BUFs (PRIME fd) from other drivers using ``DRM_IOCTL_PRIME_F=
D_TO_HANDLE``.
> >>> +4.  **Execution**: Use ``DRM_IOCTL_QDA_REMOTE_INVOKE`` to pass argum=
ents and
> >>> +    execute functions on the DSP.
> >>> +5.  **Cleanup**: Close file descriptors to automatically release res=
ources and
> >>> +    detach the session.
> >>
> >> I'd have expected the description of the actual example. I.e. clone th=
e
> >> app from https://the.addr, prepare clang >=3D NN.MM, QAIC (https://foo=
),
> >> run make, run the app, check the results. I'd remind that DRM Accel ha=
s
> >> a very specific requirement of having the working toolhain in the
> >> open-source.
> >
> > We have been getting submissions lately that don't fulfill that
> > requirement so I will point to the precise part of the documentation
> > that explains it:
> >
> > https://www.kernel.org/doc/html/latest/gpu/drm-uapi.html#open-source-us=
erspace-requirements
> >
> > For an example of a submissions that complies, see:
> >
> > https://lore.kernel.org/dri-devel/20260114-thames-v2-0-e94a6636e050@tom=
euvizoso.net/
> >
> > Most importantly, notice how the proposed Thames Mesa driver generates
> > machine code for all the hardware units, and doesn't use any blob for
> > that.
> >
> I believe QDA checks all boxes for accel, as there is available
> opensource userspace, opensource QAIC compiler for IDL compilation and
> LLVM supports hexagon arch.

I must say that I'm at a total loss regarding the userspace portion of
this driver, despite spending half an hour looking inside the FastRPC
branch that you link from the cover letter.

Can you please explain what do people need to do to:

- run an algorithm of their choice on the DSP,
- execute inference with a common ML framework such as TensorFlow Lite
or PyTorch.

The documentation I pointed to earlier explains in length what is
expected from the userspace portion of the driver, which is more than
just being open source.

Thanks,

Tomeu

> I'll try adding these details as well.
>
> Thanks!> Regards,
> >
> > Tomeu
> >
> >>> +
> >>> +Internal Implementation
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >>> +
> >>> +Memory Management
> >>> +-----------------
> >>> +The driver's memory manager creates virtual "IOMMU devices" that map=
 to
> >>> +hardware context banks. This allows the driver to manage multiple is=
olated
> >>> +address spaces. The implementation uses a DMA-coherent backend to en=
sure data consistency
> >>> +between the CPU and DSP without manual cache maintenance in most cas=
es.
> >>
> >> GEM usage?
> >>
> >>> +
> >>> +Debugging
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +The driver includes extensive dynamic debug support. Enable it via t=
he
> >>> +kernel's dynamic debug control:
> >>> +
> >>> +.. code-block:: bash
> >>> +
> >>> +    echo "file drivers/accel/qda/* +p" > /sys/kernel/debug/dynamic_d=
ebug/control
> >>> +
> >>> +Testing
> >>> +=3D=3D=3D=3D=3D=3D=3D
> >>> +The QDA driver can be exercised using the ``fastrpc_test`` utility f=
rom the
> >>> +FastRPC userspace library. Run the test application:
> >>
> >> pointer
> >>
> >>> +
> >>> +.. code-block:: bash
> >>> +
> >>> +    fastrpc_test -d 3 -U 1 -t linux -a v68
> >>> +
> >>> +**Options**
> >>> +
> >>> +``-d domain``
> >>> +    Select the DSP domain to run on:
> >>> +
> >>> +    * ``0`` =E2=80=94 ADSP
> >>> +    * ``1`` =E2=80=94 MDSP
> >>> +    * ``2`` =E2=80=94 SDSP
> >>> +    * ``3`` =E2=80=94 CDSP *(default on targets with CDSP)*
> >>> +
> >>> +``-U unsigned_PD``
> >>> +    Select signed or unsigned protection domain:
> >>> +
> >>> +    * ``0`` =E2=80=94 signed PD
> >>> +    * ``1`` =E2=80=94 unsigned PD *(default)*
> >>> +
> >>> +``-t target``
> >>> +    Target platform: ``android`` or ``linux`` *(default: linux)*
> >>> +
> >>> +``-a arch_version``
> >>> +    DSP architecture version, e.g. ``v68``, ``v75`` *(default: v68)*
> >>>
> >>> --
> >>> 2.34.1
> >>>
> >>>
> >>
> >> --
> >> With best wishes
> >> Dmitry
>
