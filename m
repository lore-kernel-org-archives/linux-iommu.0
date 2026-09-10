Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5764A456E05
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789036729; cv=none; b=UhYx81MuoWLZ5FCAEXeFK8Lh/cmqbEOqlOqTHLO0FcdMFrnx9yfbqAxkXPcyKg1hVAI5Fi705At2pagAGZYnCq2atjFXs/WarilmijTqsCfcTsAxwhbq9dqC/SVMwskn5/3JO35hDVw7qeit7jgrdLHDosWgXBo1J6xK5uRf0g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789036729; c=relaxed/simple;
	bh=unCScM6mPbDKppMrZLCM3FABFYfLuyU55r1WmWOxz60=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jwquUwZeEQXaFdGgkMQ2LN0KyRbQZnE6woV/ShuRwYJtescotM94mCk7X+ktLA9RABvZECbuwkoLzOoKAxQ+K8D88HV1R0Z2ehyySRC1heD7jE5qjEMzdmL6gODAfD+Cgkxs3ODwj40eyy1ZlstbiRcdrXj0GZYeEF5gkjoJQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=3hPLH9At; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="3hPLH9At"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c294183384fso228915566b.1
        for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 03:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1789036724; x=1789641524; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CpJbFL+rZz/M4vrqd8/z7ghAMgMKrwdsWiy44eS8/vo=;
        b=3hPLH9AtoRxFaK3xaL7eRIp4uC9xOzvRKurfuhYRM0cHa0QmAR6w8TnZFn3ZYiID4j
         Zgg1OidqXR5vzyulKruyVCVw3BptNPmXf/OTKqiGvnPo7R+5NpMiw20l6OZL2BTlKPWD
         Raam8vPAc/uA76zU2Jj/CIMe2VNmThFT0r8NA9W20n6Yprzf5+2FZ2OtuStpLebzJmRs
         zAAqYHqf19uWEjW5f72d7D3qGOGRW05Yv2Qs2LAbBCMGVdtDUUKP5KaBWAc/UzqwxTZ/
         lOQ20HuRH2wpbOWn/NSlUm5qAOR4767XTBB9OH3t4d5JfqEQsRESMRZiBnr83gefrWrm
         KOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789036724; x=1789641524;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CpJbFL+rZz/M4vrqd8/z7ghAMgMKrwdsWiy44eS8/vo=;
        b=knLcd0+w5qzNHKk5bZQQAj+VPRIr7sfYETWhrhoeeD6bZIr9/9VhM8K8SqlcRvdaAk
         ia1L8OapfkTqghToDvaEpNEFOJA0xE93fI5XoYROr+3c6TqUblkBXiOFmT84qqJMhiIt
         DmmQLkdf+tu76QXXlheSdCAQpxRf0JsUzSwZJTSU2taSQruFm7MxiLNCutEMcRf9GjhX
         d64fcDKldVPFIhLQZsNuU0BPR31k062T5IIjJCvmmBT7NGm3tqgbS97E7bEXigZ/GA+K
         vDzy9T2dCulRz2ZiGjZywW7o8ZJ9dO0nyKNLxJvQ3/EKe1/24wk1oYoslZBfuMk+WZn7
         K1yg==
X-Forwarded-Encrypted: i=1; AKwUvBxCg/IBWylFxgRAZj2OEi+R4gnJPEGjNjZ8HXyZPC2BrZTiI+Wfh07UVTDDEQihq2p4Qp9KhA==@lists.linux.dev
X-Gm-Message-State: AFuF++l8Z0XGsZhSlkuLb+MFo/PkWzdVf4PIh/vG5K3jpkmmj7rDj5Eh
	pgPm6vjV0tagf8B2pvFX8Nanx7BMUzrE5oUX3SCq2nQvYVEZjIOxMsqZHmqPDjkRrms=
X-Gm-Gg: AYBFou0PpmRXAHmaU5xTsiu0sHg6xhwafTk/lX33UJde0i/7qXlcWpVtW2kd+rZ0ihH
	GmxbsjkTF3u+jCaFSUm37rjjUG3a0TBIQLYEg+/86vyaglmO97GfGXoCBkm6Pop62VGaBx6ub8z
	oLF1oWXEcOaptnVkNap1GZRYtI2KS/JeNGVq48CnId2eucw5gNF7nhVZcU7PJokyGU8l1YFNFkz
	l/mUD0x+vVeAyhrkkD5dbrDTYBvxCB5aG8NAE0D8Aqng0+QKq5EO9vQJasO6BSK3zp3oKFcHTa4
	yCVzY1WjkbrDCvIywXqHlS8dykJQyLhVrkqTFEQTmsROsO53ljt+rEubLKoEeu2e4UCJgpwgYpR
	bnqYMaqf6dVbx61BPRMQV29ij45DeSK5yfF+4q9eWaycpJR1YNA9fydeplcTqR6dpP+Npmo6fc6
	6e3s/6Acw04yJix+ty1YmSQhqkBIfvb0ratoEl3lvtTnRCh2hS8Q5UDOX8vaNW+pXOysH/D1+hU
	LNogF/wwzAgMTSUlwNQOgcCrOqAYvqu5/WPivNhMXoN6zm4Rvic1H0=
X-Received: by 2002:a17:907:c0d:b0:c12:74af:51f3 with SMTP id a640c23a62f3a-c260c7ac988mr1629919366b.6.1789036724503;
        Thu, 10 Sep 2026 03:38:44 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d501662sm911270066b.23.2026.09.10.03.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 03:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Sep 2026 12:38:43 +0200
Message-Id: <DLBKL8SJL58R.2XQ76X6JILZ8E@fairphone.com>
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
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com> <DKL6P7G0WTM7.UJ6KZERQZDFK@fairphone.com> <iv5radfllym2bjvkrdu4ffs25bqixyos7k3ymncpcdtc2uobn2@zlhsybrj3pwz> <DKX384NK76OS.3NNOMAH72PV2P@fairphone.com> <ssleznoahzs4wgf5irjiagss2rjwl2s2jjnqrrnlpp74rdkgfs@au6x63ykyjfs>
In-Reply-To: <ssleznoahzs4wgf5irjiagss2rjwl2s2jjnqrrnlpp74rdkgfs@au6x63ykyjfs>

Hi Dmitry,

On Tue Sep 8, 2026 at 3:28 PM CEST, Dmitry Baryshkov wrote:
> On Mon, Aug 24, 2026 at 12:04:57PM +0200, Luca Weiss wrote:
>> Hi Dmitry,
>>=20
>> On Tue Aug 11, 2026 at 2:43 PM CEST, Dmitry Baryshkov wrote:
>> > On Mon, Aug 10, 2026 at 12:16:19PM +0200, Luca Weiss wrote:
>> >> Hi Dmitry,
>> >>=20
>> >> Many thanks for working on this and sending this patch series!
>> >>=20
>> >> On Sun Aug 9, 2026 at 10:15 PM CEST, Dmitry Baryshkov wrote:
>> >> > Qualcomm MSM8974 platform has five SMMU instances, used by display,=
 GPU,
>> >> > Venus, VFE (camera) and JPEG encoder. Each of them follows ARM SMMU=
 v1
>> >> > spec, however they differ from other Qualcomm platforms in the
>> >> > implementation-specific registers and also in interaction with TZ.
>> >> > Venus, MDP and VFE SMMUs are secured and require programming only o=
f
>> >> > CBs, while GPU and JPEG require full programming.
>> >> >
>> >> > This series skips IOMMUs which can't be tested right now (VFE and J=
PEG),
>> >> > and adds only MDP, GPU and Venus (although untested, it is required=
 for
>> >> > display to work) SMMU instances.
>> >>=20
>> >> I do have a patch series (sent years ago to the mailing lists as well=
)
>> >> for CAMSS so I can definitely test this in the future.
>> >
>> > Ok, let's land these first, unless VFE IOMMU blocks display on your
>> > platform (Venus was blocking display on APQ8074 DragonBoard).
>> >
>> >> > Note, to get display to work properly one fix is necessary, [1]
>> >> >
>> >> > [1] https://patch.msgid.link/20260809-msm8974-mmcc-fix-v1-1-50f2dcf=
18d2e@oss.qualcomm.com
>> >>=20
>> >> I've applied this series on v7.2-rc7, with the extra commits between
>> >> that and linux-next for qcom_iommu.c backported so that your series
>> >> applies without conflicts.
>> >>=20
>> >> So far I'm stuck with the GPU not being able to probe, adding some
>> >> printk's shows that in msm_iommu_new() the call for
>> >> iommu_attach_device() is failing.
>> >>=20
>> >> [    5.971154] msm_mdp fd900100.display-controller: failed to load ad=
reno gpu
>> >> [    5.972991] msm_mdp fd900100.display-controller: failed to bind fd=
b00000.gpu (ops a3xx_ops [msm]): -16
>> >> [    5.974073] msm_mdp fd900100.display-controller: adev bind failed:=
 -16
>> >> [    5.974152] panel-s6d6fa1 fd922800.dsi.0: error -EBUSY: Failed to =
attach to DSI host
>> >> [    5.974230] panel-s6d6fa1 fd922800.dsi.0: probe with driver panel-=
s6d6fa1 failed with error -16
>> >
>> > See the patch [1], it's picked up for 7.3
>>=20
>> I missed replying to you, with this patch the display lights up again!
>>=20
>> Unfortunately the GPU still seems to have issues, I don't have a log
>> right now (I think even SSH was dropping then with a bunch of log lines
>> appearing in kernel log on screen). I assume kmscube + more complex
>> workloads worked fine for you?
>
> I was mostly using kmscube, but I can try running the CTS once I get
> back to it, sorry for the delays.

Yeah, kmscube doesn't even work for me.

Bootup works to a tty with screen on (mdss doesn't seem to have any
problems for me), but then as soon as I run kmscube the device shows a
few errors on the tty0 on the screen (USB stops working apparently since
my "dmesg -w" doesn't show anything) and a few seconds later the device
reboots.

dmesg: https://public.lucaweiss.eu/tmp/fp2-iommu-dmesg.txt

The SoC in my device should be MSM8974PRO-AA (a.k.a. MSM8974AB-AA).

I know there are some differences for some bits between MSM8974
(Snapdragon 800) and MSM8974PRO (Snapdragon 801), which variant do you
have? Maybe that's relevant, also since downstream splits devicetree
based on 8974 and 8974pro.

Regards
Luca
