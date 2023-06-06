Received: from sonic304-48.consmr.mail.ir2.yahoo.com (sonic304-48.consmr.mail.ir2.yahoo.com [77.238.179.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8866F28C3A
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 10:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s2048; t=1686047330; bh=i9WGBO+c8Sq9QutdxfoEb6v2ufl1IHpOWj86CF3oFCA=; h=In-Reply-To:References:Subject:From:Date:To:CC:From:Subject:Reply-To; b=jwrumPCQ7z5jPbKV5M2BMZv5mKCQ8Lut0f6Awx8clBVgxNfPz9Tnb7p+UzW3ISbflo6nBzaS60iaS1AntXM5RjzkV8QL1auZCPYP+98hzqCwZdOs3tYg550tFJEwJZ2cBPRlXcSUdzrvBr434Toal9Mt9uhX/tcwHLiUz8Do1WTXHaRGdb6Ut4se+gh+fYZVnKVdsd4LokjA89mIpYyJJ2xbsi5zXX5VgGhZ7VEd1B/DIg3jObT+o3V843dAf26YNDndGkgaQ0yIfjfKrBS64QGZe54MC6inr1v53T87i1q0xGkemuK7wgMipFwWSkQ0xcqBZPk9PH8fug3lOFh4yA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686047330; bh=+78klkUrMJd0bK0ctb3jT0/9zGMqb6AYJYAEXbuBj7o=; h=X-Sonic-MF:Subject:From:Date:To:From:Subject; b=d216UeCoSgwBtfIaXD9c+1f6ELjWrFDSHKsrR+Sw4hLA7x8osPRn9XBv+5ShdavGhLScWBa3HFkcPidkaOQUsUSlMQ4Vtc6eGVDdorr0E+n8ShqChDUFGANE5wN24LDP06dnkaDdhC1DNEGKAYJ3yFsS+E5657Fx/RhP773LVfdzoumWVykxvPH6Io41tU28pWG5PgGnaNt5cGWSikuRcB613rL9XRlkDli5Q8dKMLPHzDsXGBHKl87LZ+y/C5Wzqt77V6YiT3+CUl7NA3g8cjJ4DA7gq9v8aVG92yQn/1VBcGbrcsC/1o8IWDxvA9QG+0xccfSg3471TiPSL9l+gg==
X-YMail-OSG: BJXvtHoVM1l3i9c1eM3.yhx4AXIflO9UKcJKoNhxbNYT4Pj2uFySDxx5TQqxhcD
 ZnLmxFTd9Y3P8Mfx2pzhUbXc64Lf7Lw2.DICYIujrObVvXpp91SbNR85uSbisfLHkbgQobRwLzHp
 SLh5_ut2n5iWDxORGeElRhBaafBTvWZikS0VsEWMlnT_3kNZqrtoOTQwb7Hqo2BNMTBt1hT9cC99
 lBkpn8g9u0ws5Nt5VbED8OWrFdJBtcamVGwcA3i_llp54izR9i05HZvW0KaH_kf6VikmTj16W77f
 sApA1dEAfbI5Et6OHSZtgB47pePRwv4Ge2i8F8w5778G7NJY7lgdWUs7q4yt6tiRhjWQiM0FU6jp
 mjplGbEWfuTzOCjNcQI38x3KqTVhEWPXclMAtqTPCC0xlDCyTrGl63CymsduosatbvedyZ50FaqR
 uE_.jHX5QKidBghuL4UgKUoSNUSk0zU1rCVZyJh2o184.pOYBHZvb9DagjDrx4wi2cq3ThHBO3py
 A.Z7KqdtgeT5G7WpmT5EClk1N8o1U7GXZEEzXzYED4e.9M_w3ZKAOx.RYLrXl1ihoB8gbUp6u4mI
 gma.HvAS1jtLDuAo3GqzzxSN490t_glJtZSOot4NW0AnfYUiNAoZzQt0xGsftK9TZ2c6_dK7Hi6b
 PPZjSCJp9bAlszcjRZt5wsYkXFYU_5jFaSwP5tXGE.J3gvys0XxzwyKJ64qMRNKikJvJLJ12YvKq
 ihtMhCXbH.VwatckcBPccvdTEoUG_O3ksNN6wF6gNx4qTASrzY09W3Xk5HFS80LSk3u4hH3x1YqX
 00hIqL6DKFrJiW9v63ccE6hAi0SSeWxOkv7TjqG_Zqu.5BFzsQOfeSDeTmVUd72IePsogWcnsPUQ
 Xl3iyJ0c5JBZTqkj6pc2Qc._UPgzw40aNKB_Ro47cTzpoqz411mdKMWF4JPJOi6KNyIFFZknHJ.9
 UkNdLxcc4mFm3W2bZ0Vn3fgoziV1PWuznRPjH6y2sXxN6ckVM1TZnuZyNRyTLmUHneLO4ZYC8tbH
 T1d1M2dA61FxTBHM7X6ek1eqGsPLPzViTHNVtbNJ95ECr3odZ657zDrWwblwu6sbYXYa5t45VxDD
 EY_8n.oRrGibWQJDFHFhfE5xIlWcEJP_bPmI3tvQInS5hpPbfU5N3mZvePBmCOxDwxK4VzHJep_5
 n14nBdAh6oR9_mJ.htzofnC.edhpRqPwTlLfqSOO8jFAbrLptuMSArxgJZA6xLrKbAJxK1_tz.dm
 CSv5GpyINX0LgwDLy.y.w8wbG9IUAi8jsApAwe0250cui3kLCEWisp_WebDw_E6iOWQvEJCzG.89
 tE6gg90OmJUGQ.6Ux4a9vxTv8GkUbd1d.cXyIR0fFvMa2UGbLqbrXPtSJduqhmOAeDgyKsPxZFmn
 d5Ks.Tdp6UEkkkRQv9RDl77Cf4iOiseP54Phwf_0R_MKJCQ4EnjSsgnJC0CYqAea3sLx3iyBrgRp
 zGi.yjw1m1lJYxOMWJDYfqepCtdcTaFALvfImTz3EJNx.nuORSyJeX0HaxiQAAv54lY3Hi98kQIm
 _UXfJXxLw1nr0.Xjy9f0ikTLLCfkkSBSgV1Uvl9uFwcpto21OkbhZm8QEvaVqjQBsUopSr0cofaE
 qMMU0uvcF30Qrz0lpqM4r8gAELtoA42y0LZCVAYGbQHodgz1PBmim9s7flPFy7WYPz9UY6mlUGdr
 9FUzlUbuc5v2YBn5xRhLRGbc2peOGYDrICTePf5KIkBs_qK4b9.TGZWm.omRsL0Rkjg14bGk6gxM
 zaBUyQJYYjEMdRnEsiXzPhEPa2SOMMT3wCQa4Xt0BrHOYOfZVaZA1.WEBFzitpIQ2YFCedcB9LoI
 Ldm1_cnL_ea9xkxN2U9J2LWseSD95Y85d9zKNq_7EQgfRh9UBskvZgPttISlqwje.7iVdLDGLteS
 bBVm8dW1l_K8TBreEUt_a0CRFud9J0N87Xvx2HAC7_8NppU8Kxsx3kV_Rv3XZ9RI8DpHgK_b10MH
 9VRhbH_6Whd5dbwZKEEaEoVCShDbFXFsueRlCNkAfYxDD0qNccDsMsetF0fUDRu56nhlceOuXoOF
 XYNrFYnin7dnJRyntC42N07x8KinjKe.aG1cmpwpMJThZtTD6Ie.aG07FAxxeRAaQXYJ1fGH8FW_
 RgmB_XZdcYpkc9vuSDehHlcCvIMhUfjFxuTMJJSfcOH.1NXM_5Gt4awaRDer50vqHq7KqiyI6wTq
 oJblU_UC7kHH9gV4rdsepC7GUqIRjiUfeIsFxfKXdLF0jU2Y7gZI_qz3hPAZSoCB5.UbdpbGgOSS
 O
X-Sonic-MF: <jason_a69@yahoo.co.uk>
X-Sonic-ID: 9972e69a-94c3-41e3-8466-d84becc79565
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Tue, 6 Jun 2023 10:28:50 +0000
Received: by hermes--production-ir2-7867f454fc-tvsct (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 68df479e0d7d80a4b5a654c5c56e996f;
          Tue, 06 Jun 2023 10:26:45 +0000 (UTC)
In-Reply-To: <20230606092435.GA31061@lst.de>
References: <5f37b0b0-6cb5-b210-a894-d1e91976126e@arm.com> <2a699a99-545c-1324-e052-7d2f41fed1ae@yahoo.co.uk> <07ee0cf7-a5c2-f87a-d627-8dd8fb082345@arm.com> <9648f668-a3bc-3296-71d1-c91cd4c9980e@yahoo.co.uk> <1539e760-392f-a33e-436e-bbf043e79bfc@arm.com> <14f2b1ab-2c7c-fa4d-5854-3df08ac9feef@yahoo.co.uk> <1928df45-7b56-a8a4-21b5-22e5d8ef95eb@leemhuis.info> <9b602abc-37e9-f236-37ee-71bcf1b7ce66@arm.com> <211f3938-2f93-cad7-a92b-821d3ac45b9e@leemhuis.info> <c7da7095-7d68-c65b-daf8-7eee43b79d53@leemhuis.info> <20230606092435.GA31061@lst.de>
X-Referenced-Uid: 898482
Thread-Topic: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2 kernel with Marvell SATA controller 88SE9235
User-Agent: Android
X-Is-Generated-Message-Id: true
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Local-Message-Id: <a1128e23-e0b7-41aa-b432-c28cd0dc39b1@yahoo.co.uk>
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2 kernel with Marvell SATA controller 88SE9235
From: Jason Adriaanse <jason_a69@yahoo.co.uk>
Date: Tue, 06 Jun 2023 12:26:42 +0200
To: Christoph Hellwig <hch@lst.de>
CC: regressions@lists.linux.dev,Robin Murphy <robin.murphy@arm.com>,
		Alex Williamson <alex.williamson@redhat.com>,Bjorn Helgaas <helgaas@kernel.org>,
		baolu.lu@linux.intel.com,iommu@lists.linux.dev,
		linux-kernel@vger.kernel.org,linux-pci@vger.kernel.org
Message-ID: <a1128e23-e0b7-41aa-b432-c28cd0dc39b1@yahoo.co.uk>
X-Mailer: WebService/1.1.21516 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

I'll take a sub credit =F0=9F=99=82

On 6 Jun 2023, 11:24 am, at 11:24 am, =
Christoph Hellwig <hch@lst=2Ede> wrote:
>On Fri, Jun 02, 2023 at 03:07:19PM=
 +0200, Thorsten Leemhuis wrote:
>> Christoph, could you do me a favor and=
=2E=2E=2E
>
>> =2E=2E=2Esubmit that quirk, as Bjorn and Alex apparently did=
n't pick this
>up?
>> I could do so myself, but prefer to leave that to peo=
ple that
>actually
>> known what they are doing -- and thus can also handle=
 problems later,
>in
>> case any show up=2E And strictly speaking it appare=
ntly was you who
>caused
>> this regression with 78013eaadf6 ("x86: remove =
the IOMMU table
>> infrastructure")=2E
>
>Well, Robin posted it so I think =
he should also finish it up and get
>the credit=2E  Robin, can you send the=
 quirk with a formal signoff?

