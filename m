Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8313EFFDB
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632692; cv=none; b=VmO0TFU5uNluX2LZQliDCfNzZOoTP2efNAORpmhnJ1oO/OuFvnwGxNdLbtwdvHQGRC5KF4XMdcO8WmHln0lepLwSX+ZnoIadgndy3WAcdOVFJoYSxDBXVy5JHjM+5Nmt7gfY5Wo6i5gsR6qhSKsmhLMllaQCxxNR6jiMVJMsE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632692; c=relaxed/simple;
	bh=pPdt+eVUGT67x+IwAHC1ZsE6n9l1yCrm23aUxT3YHnQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pOKVeNCw4mO8N/zO7O9N+0nWhYzdpPHjTE4J5GnRwBXfNUX2PEJ1aTpanAxxn2SvkFZ6ZRzSxjhufQw9uU/iOLE+uXLylHdarTf3PYe0JUs+4NRMuoo1Y+yz4yzm5eVqO7UqQB6QVwygjzGh4HXmvsSORaOu6bxh7hJ9vlGw8sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=XxU/ImY4; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="XxU/ImY4"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9a2b95b72so878401a12.2
        for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1789632688; x=1790237488; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ul3iVroMFe8qrm8FbvVkT98nKEMOhIID1sGLRlIk0SE=;
        b=XxU/ImY4g0hnbo0PPANDZZMlz/CKuEM/MXqHc2RcgkPB5AQu/paPZgFnijIdTbu8PX
         LIZd7OHCJL+qDjMzNjOaHmhcw46Fe8H1yCrGHv/UFHb2Q+0kb2FNujFCMTZIj+T5LzP9
         hBsGSVEJSBCaF7wcGRmqAJ9u7/p+w0cLAwNZ0UrNlPjfdBqhp5uWySBWDS9ZqJB1N/lp
         nuZXv9x/MaItzqN4gUVsG7whF7NtjxdBL9R3i8NG3zJzoIwV9Rl4+QbaVC2ir969vyuN
         NxsKiGJ438yoT/Yv2a7qT0YI0sc7mffUmcYVfeuV0lwiExyHjxUju7hu7xXzaFf8cQwt
         kiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789632688; x=1790237488;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ul3iVroMFe8qrm8FbvVkT98nKEMOhIID1sGLRlIk0SE=;
        b=0FD3xoWeQAP/WNaqZ6O+eFlZeUJWH1Skyet8lIGwhMKI4tUaVA/tnhqfIpCG6012ty
         4fjCPsyk34jpFfJe2NzIwz+Lh6gZ1VsEPXqAjFgZECeB6ZlJP1Tl0IVGK43/Nbz9t7H9
         YXD196yxLLdeqvic1mCXY9AhtfbbPwwIE59Hd+bnH68USR1EeaVb89TKAurEF0B2rqpk
         h1a2K/IVDlHD/nh5eeU8Ks4AFQAdVR+HJSD4LmgwRtlsecd5RfwK6Fekw4SReqSTbSF7
         lSxPO34lzOzaV90ohhno8MZtVXEZcT7QVQdmo3w762ky94cfPXDHDoEJmSLvUrj3nxtr
         oVVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAC3Jtbcah9/j3n6xHYDZygd03aI615IV40ZgYbYA3MTbt/DsHYm3oNE0ABEeLEY0hj/h6RA==@lists.linux.dev
X-Gm-Message-State: AFuF++n+66ZOIkR4kiYQkBo3VvQWtogdlImu8LEKcl16jUbuJjBxRuBW
	RKdIxoEg7Um/2HDb4HH+v2Z4RqpNaOPP8ALf7wfsZvlDdRNAQOopRtXUPhw2pPb+W20=
X-Gm-Gg: AYBFou1bpth/wf4keAyHkeiwon2BAt1yjAsqbs62mtWtpQvyf3jEZik8Ofu44uzBCsz
	vTDMh3FqCXvWYsDiT6YGm554yux7J40D29Mn8qEufcx/2rnMmWf8TS3m1jDVqicyJLjR+eEZWn5
	BH/Af11hHJBP56zZXRMTM0P2cHbZpVe4+l+sQSPjXpRTrpXfFn9rWSvA/T/tk3SOFCbPj89ATYg
	zt1nSx+WoCERwpsms84XzqUnMgI+RkB0QJ3MU45fN2+VBtkf9aadAy9uAh0eacTmTiAiceaT+Aw
	ShdwI+7ZBK28JzctafUBOmADvVbbEah3GhqYDGsUN8TVqRjPhZKrzRnUvZP0dlOokykEQ1f8x1k
	rwGRGoNHPQwyiCxJvFvGT+5C5I+24UTQqjk1isydHSAj+y+8jaKeHRnm/QmG6DOW9Z386nOSahg
	UlaCt5jHzwk5TJPNOwNygLpFxDUhp4AOrAHOgLTX1sg2ewgID5o7vHIUD1U5wNa7FMaknK1BKd9
	gb9ppRCeQYOH0p88k1t+tfG6YcSlwVxIBFVjicMq3A=
X-Received: by 2002:a17:906:478a:b0:c29:1133:e17b with SMTP id a640c23a62f3a-c29e523e769mr435122166b.19.1789632688364;
        Thu, 17 Sep 2026 01:11:28 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de63c5e7sm238690466b.53.2026.09.17.01.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 01:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 10:11:27 +0200
Message-Id: <DLHFUAOHVWN7.1K596C038662Y@fairphone.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
 "Robin Murphy" <robin.murphy@arm.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Clark" <robin.clark@oss.qualcomm.com>, "Bjorn Andersson"
 <andersson@kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 00/12] iommu: qcom_iommu: implement support for
 instances on MSM8974
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com> <DKL6P7G0WTM7.UJ6KZERQZDFK@fairphone.com> <iv5radfllym2bjvkrdu4ffs25bqixyos7k3ymncpcdtc2uobn2@zlhsybrj3pwz> <DKX384NK76OS.3NNOMAH72PV2P@fairphone.com> <ssleznoahzs4wgf5irjiagss2rjwl2s2jjnqrrnlpp74rdkgfs@au6x63ykyjfs> <DLBKL8SJL58R.2XQ76X6JILZ8E@fairphone.com> <CAO9ioeUEQ+kzBLj3KTv+uayaE-5aw-aL49-0pJ-x_Vwq4nu9JA@mail.gmail.com>
In-Reply-To: <CAO9ioeUEQ+kzBLj3KTv+uayaE-5aw-aL49-0pJ-x_Vwq4nu9JA@mail.gmail.com>

On Thu Sep 10, 2026 at 4:20 PM CEST, Dmitry Baryshkov wrote:
> On Thu, 10 Sept 2026 at 13:38, Luca Weiss <luca.weiss@fairphone.com> wrot=
e:
>>
>> Hi Dmitry,
>>
>> On Tue Sep 8, 2026 at 3:28 PM CEST, Dmitry Baryshkov wrote:
>> > On Mon, Aug 24, 2026 at 12:04:57PM +0200, Luca Weiss wrote:
>> >> Hi Dmitry,
>> >>
>> >> On Tue Aug 11, 2026 at 2:43 PM CEST, Dmitry Baryshkov wrote:
>> >> > On Mon, Aug 10, 2026 at 12:16:19PM +0200, Luca Weiss wrote:
>> >> >> Hi Dmitry,
>> >> >>
>> >> >> Many thanks for working on this and sending this patch series!
>> >> >>
>> >> >> On Sun Aug 9, 2026 at 10:15 PM CEST, Dmitry Baryshkov wrote:
>> >> >> > Qualcomm MSM8974 platform has five SMMU instances, used by displ=
ay, GPU,
>> >> >> > Venus, VFE (camera) and JPEG encoder. Each of them follows ARM S=
MMU v1
>> >> >> > spec, however they differ from other Qualcomm platforms in the
>> >> >> > implementation-specific registers and also in interaction with T=
Z.
>> >> >> > Venus, MDP and VFE SMMUs are secured and require programming onl=
y of
>> >> >> > CBs, while GPU and JPEG require full programming.
>> >> >> >
>> >> >> > This series skips IOMMUs which can't be tested right now (VFE an=
d JPEG),
>> >> >> > and adds only MDP, GPU and Venus (although untested, it is requi=
red for
>> >> >> > display to work) SMMU instances.
>> >> >>
>> >> >> I do have a patch series (sent years ago to the mailing lists as w=
ell)
>> >> >> for CAMSS so I can definitely test this in the future.
>> >> >
>> >> > Ok, let's land these first, unless VFE IOMMU blocks display on your
>> >> > platform (Venus was blocking display on APQ8074 DragonBoard).
>> >> >
>> >> >> > Note, to get display to work properly one fix is necessary, [1]
>> >> >> >
>> >> >> > [1] https://patch.msgid.link/20260809-msm8974-mmcc-fix-v1-1-50f2=
dcf18d2e@oss.qualcomm.com
>> >> >>
>> >> >> I've applied this series on v7.2-rc7, with the extra commits betwe=
en
>> >> >> that and linux-next for qcom_iommu.c backported so that your serie=
s
>> >> >> applies without conflicts.
>> >> >>
>> >> >> So far I'm stuck with the GPU not being able to probe, adding some
>> >> >> printk's shows that in msm_iommu_new() the call for
>> >> >> iommu_attach_device() is failing.
>> >> >>
>> >> >> [    5.971154] msm_mdp fd900100.display-controller: failed to load=
 adreno gpu
>> >> >> [    5.972991] msm_mdp fd900100.display-controller: failed to bind=
 fdb00000.gpu (ops a3xx_ops [msm]): -16
>> >> >> [    5.974073] msm_mdp fd900100.display-controller: adev bind fail=
ed: -16
>> >> >> [    5.974152] panel-s6d6fa1 fd922800.dsi.0: error -EBUSY: Failed =
to attach to DSI host
>> >> >> [    5.974230] panel-s6d6fa1 fd922800.dsi.0: probe with driver pan=
el-s6d6fa1 failed with error -16
>> >> >
>> >> > See the patch [1], it's picked up for 7.3
>> >>
>> >> I missed replying to you, with this patch the display lights up again=
!
>> >>
>> >> Unfortunately the GPU still seems to have issues, I don't have a log
>> >> right now (I think even SSH was dropping then with a bunch of log lin=
es
>> >> appearing in kernel log on screen). I assume kmscube + more complex
>> >> workloads worked fine for you?
>> >
>> > I was mostly using kmscube, but I can try running the CTS once I get
>> > back to it, sorry for the delays.
>>
>> Yeah, kmscube doesn't even work for me.
>>
>> Bootup works to a tty with screen on (mdss doesn't seem to have any
>> problems for me), but then as soon as I run kmscube the device shows a
>> few errors on the tty0 on the screen (USB stops working apparently since
>> my "dmesg -w" doesn't show anything) and a few seconds later the device
>> reboots.
>
> Interesting. I wonder if it's TZ tripping on the VFE IOMMU.

Do you have any suggestions for me to try?

>
>>
>> dmesg: https://public.lucaweiss.eu/tmp/fp2-iommu-dmesg.txt
>>
>> The SoC in my device should be MSM8974PRO-AA (a.k.a. MSM8974AB-AA).
>>
>> I know there are some differences for some bits between MSM8974
>> (Snapdragon 800) and MSM8974PRO (Snapdragon 801), which variant do you
>> have? Maybe that's relevant, also since downstream splits devicetree
>> based on 8974 and 8974pro.
>
> Mine is APQ8074, not sure if there were revisions.

Maybe /sys/devices/soc0/* or /sys/kernel/debug/qcom_socinfo/* has info
about the revision? But maybe it's also not useful. I checked a bit more
before and all msm8974-v2 downstream seem to have the same IOMMU config,
just msm8974-v1 (which was barely shipped?) has different configs. So
hopefully the SoC revisions shouldn't make a difference here.

Regards
Luca
