Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5361F91E3
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526018; cv=pass; b=vGeAOVtHfLhB02H7IbfvGg6MqNG428xhTa/hufUNC3rubPSboNS4iLm8Ce6LuBmBVWXyjvm3FA2pJnJlKhONKrJl2OHK+4RjXr+bSH4+U/Q+Nyqrcdl0ov+uwV6iwnr2e9RYmlMsITe/cIMl8jyPOncapy0r4LLnluY7DCyYI0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526018; c=relaxed/simple;
	bh=XXMW7relNtjI3OlVKlyi+Ft3JX4ZesBdNhaW/5GXYrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHD7p57whx6himQ1jeqqtz4rDE877VZMWFmYzeYadVbHmnQsjPonR3pbB4bBLNaMLUwFdIO9aAb3r6E/Bpz1lkCeF87Y2UufDY8OD+4SYcCLQwVmJIdPX+cl9WCUrdp7VX9FBjSg4AKLt2vkF3GXUhg9R+L6I6okMNPZ26EZZ10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=CGBV/eaf; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="CGBV/eaf"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79db5e18ac6so49937197b3.1
        for <iommu@lists.linux.dev>; Mon, 06 Apr 2026 18:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775526016; cv=none;
        d=google.com; s=arc-20240605;
        b=EwrR5dWgXn9wMLPDAU5qqBQmLk+E4eoFo7lxlDJCf+14yM7gwW59xDsK7j/6fqLlYu
         AZyURXdqIK0lKh7XNFre98FYcD/1NTqHtlNjtpYZBJWwMOqDPKSHhHCLRkBa8l7nw7eV
         3rBupUX/hnKAI4M9NRNjiPcwzGoTNENxGrJSfCKu5euSt6Fv3dPCEFUP5NXyeugX9bn5
         UZ+YIz0/XgIcs73EoBXKsAQ8fHswk6h2fGy2Pm5mVwGHGUBsTh9yb7gPMdD5Rmm3xgMm
         v+1Jl6d7U608XjZVfaM9Q0MxQM8xZRPoGuJ8E5dxjDmlvdKmD0XUwaokVUPPN0LHx85s
         ANLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LvWAUmXAZy3o2BWzlw2ffM4oCsS5sbyymkwh9nuK7C8=;
        fh=0btDI2R3CSr42TPAFn+lU9Wsnd0vIHxhnxj+jSDK9Po=;
        b=RynTuK1ShhWMSP6XDpSawHLH0Y6aHQ34UVCkV6PSK9QNRL/q++mD2/5BjaaobkmWWo
         Rz4WfZWjt7Lqd+6Jy+NjkJCEDv+4qI498cW8i1NbDkup34Se+zVpFwG6rjyjCr2rAYOF
         6LJXFsQVjarLdnVCfSE+mjtVFIYb7EwJFSjtGTMXW+IdurU9FXBQh0eWxzx5gz+JwYbe
         oWMN2MYuTxnc6mojUWz8fGcRG06zkhhSMlibboXlLBqn3D29oT1UZnXUemsplN0EUxqM
         tYX1aA8g6plwb4cYrMPzMDRD7EI0zDSAOKIIMFm3K1LdosKN4tbAzGRhBq//MGAPwwDw
         PXWw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775526016; x=1776130816; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvWAUmXAZy3o2BWzlw2ffM4oCsS5sbyymkwh9nuK7C8=;
        b=CGBV/eafESx2Rz1SGJE0UP22+fSLxYErzXej5irT3RRpXrrgqH/tMBETcn5QGpJrhn
         YtJzImAPfVlhQ/6T356vjLc5mc1buRj00J7DtkVKd58uoiK7pt62m2quE8E+Rob0v/3b
         Qy1AO0rWTeA+9h5eTDnD5hNVSQBRC+8yWyp3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775526016; x=1776130816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LvWAUmXAZy3o2BWzlw2ffM4oCsS5sbyymkwh9nuK7C8=;
        b=qe5ks12MwY2YVmsYiJwsTlc+KJEzbIe2t1b474p0YFXPzR+Uz5QXA1POQ8iYldcxw3
         2FaCOL0fOWrvVkE+H6fLDhTkNmKQKuiUdLQVxrW58s4PXK0WFCoKa2H6qD2QVyNsmJS/
         bC92gCJd53e9VT0HF3ysWF5/h9IRr/p2cN4MsazsyaFcyrnKqRSNlYUDrgVPq+wHdF2A
         rGuqvBXx+D+TKzJmspXw9Y3dB7iUHTao0BNI0DR2JEgwKgEBJc2c41AxujqY16AgmuTs
         YTg7Cz/o+4D616G3lcRBoRAt3YB4sJPJMFl8zU5fBLIidwA5HzXuNPZOfQQuVoTkVpWI
         f/AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDqfUtuq2weQ/g0uhX1VHtkmbwsvztsY9OZJxJYf/b/n4Qva9OVOwgTtY82ILLpGvu+HtC/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+NYfIeQa5aSwYuZ/TlZvdRuJpa5HdEiLHKUpEO4g3tURVduUh
	TC5eiMHQhi0T8B7V4XdXlgWz4rbJFmCRy+7NEqtmRjPIJuPzncNElkmfD64Xb//RGszKlnOv1FU
	R+M0xX/yGSuiQWcQoRiY1lIAQ4Ke0s/BkNhBXCBdjow==
X-Gm-Gg: AeBDiesSa9Ud9+Hn/6n2ruR4gTAuVp61cxjof/D/KQ1bdgZQNv0oO/aUsrIyA48MQr+
	z/mAmprrge6glfEIUJbcdsS02pFbIEaQ3g5dXexCqoY9BaB0/t/rfuTGD1aPqUOzp+d9avniKgO
	Qro9T/Uu5oZWDLUmvLutyTBcQz5FJ7q2k9aJN98aooA0QOyJdBfpZnorqbwBPs+iWXK6gkeaQze
	Z9rhbW3glq5fcrvZZCMz5RxIfpcR6GUejtYflfdRj/QU6y0/9KW4tI0+kWnTcfplvFi+8CZb/SE
	fzVYbQKnUD+ANtLNeMhz71nzTgU0veetn80sAzDUXDCVAwZFJkqB4g99YkQt77RByKVeOTUnIfo
	ym2+k45BfkS3UernNggO6oYjA4ZeMRVtXRz5DN6Wa96jry2iFH3T7e2g/pG9t2+M=
X-Received: by 2002:a05:690c:6b12:b0:79d:fca8:f7ef with SMTP id
 00721157ae682-7a4e175268cmr123222207b3.22.1775526016081; Mon, 06 Apr 2026
 18:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAJpGJTztK=BTvr6s_e4epJffKchmXmqba82wxE_SOXUN6FWYg@mail.gmail.com>
 <20260407011210.GM2551565@ziepe.ca> <CAAJpGJQXnMjhC4C7Z6bAQJN5y48fsbiwPd3YF5vft+1MBNFLVQ@mail.gmail.com>
 <20260407012726.GN2551565@ziepe.ca>
In-Reply-To: <20260407012726.GN2551565@ziepe.ca>
From: Sina Hassani <sina@openai.com>
Date: Mon, 6 Apr 2026 18:40:05 -0700
X-Gm-Features: AQROBzAsvhI6uzGy87ToxM_BIezPmb4fV0dxfq2d7djAct_KKN9qJE6yw7wH9-Y
Message-ID: <CAAJpGJTNKxCfcZxgDj_sZYUozrOe=vxbWUUi4PVwdfvGx=WEfg@mail.gmail.com>
Subject: Re: [PATCH v2] Fixes a race in iopt_unmap_iova_range
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Aaron Wisner <awiz@openai.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 6:27=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Mon, Apr 06, 2026 at 06:17:24PM -0700, Sina Hassani wrote:
> > On Mon, Apr 6, 2026 at 6:12=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> w=
rote:
> > >
> > > On Mon, Apr 06, 2026 at 04:07:01PM -0700, Sina Hassani wrote:
> > >
> > > > io_pagetable *iopt, unsigned long start,
> > > >                 unmapped_bytes +=3D area_last - area_first + 1;
> > > >
> > > >                 down_write(&iopt->iova_rwsem);
> > > > +
> > > > +               /* Do not reconsider things already unmapped in cas=
e of
> > > > +                * concurrent allocation */
> > > > +               start =3D area_last + 1;
> > >
> > > area_last can be ULONG_MAX so this literally overflows to 0. It is wh=
y
> > > I formed the suggestion I gave as I did
> > >
> > Yes, in which case the  if (start < area_last) that follows will catch
> > it. Are you suggesting I compare against ULONG_MAX instead?
>
> iommufd does not have any overflows to 0 and rely on it tricks like
> this. You should just compare to the existing iteration last
>
Just to confirm that I understand correctly, like this?

+               if (area_last >=3D last) {
+                       break;
+.              } else {
+.                      start =3D area_last + 1;
+               }

> Jason
