Received: from sonic317-20.consmr.mail.gq1.yahoo.com (sonic317-20.consmr.mail.gq1.yahoo.com [98.137.66.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C2319E810
	for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.66.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107219; cv=none; b=qsUcuKb+X+CR24xFMFi+z0O+J5E8UpcWcgmW6H/mGFsVVY2QaC3c9ZLVbU3mcMaggdr0iRG3nV8veeVQTlz/oXgaTEp+vwfTtwvPyLsdT/BssoKKnURRzLZcijMwQ7P2umA4bOt8qRrsMldr1K4Eqi5MvObxnSgmwECeIKgL7gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107219; c=relaxed/simple;
	bh=m7gmdD8IR1GDnTfYGVrscBmNtC8GQJ1KViOdGMI4G1I=;
	h=Date:From:Subject:To:Cc:MIME-Version:Message-Id:Content-Type:
	 References; b=FdRHfix+UdO4ndhd5XsNvpNWMP+osri7XWD6ZEIXQhimnRYpQILwcFt1TuOqwp+mmm1SfU5ko6iTHbVbyLp3w8NCSuZppeCgZuzQHqScw1PwwDbONm8U9HEjALAdMH+EyF2QWOSRkvABfqBII5FsIAtTEOUPKLUGzXDxPW/AUn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.ca; spf=pass smtp.mailfrom=yahoo.ca; dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b=SMxaqXDt; arc=none smtp.client-ip=98.137.66.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="SMxaqXDt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1727107217; bh=m7gmdD8IR1GDnTfYGVrscBmNtC8GQJ1KViOdGMI4G1I=; h=Date:From:Subject:To:Cc:References:From:Subject:Reply-To; b=SMxaqXDttTpj3Me4V+0Vc+GPVgFnGHbJ2FI4Rv6fWb/d0+6zhbCOPmfzG4ubQwSzdRjThRGYBhcFcYj//B58gynddZmKkaM+SEKl98/4FjxJKe0Tqkql0qMX5d9U+/a/V+hpdiHINFG62Yea/gVsu/7GAIJ34tWVkPlJeK7Wg53JF/rzOmjG9hTrgwQYppoCR9zr+k2LzD9C+Wx1SX8AtbgDtdn9ypw6Fxs/zs8PHdolqWcx7Aa2zz23SlB3/y49d4DudzM7E/uW3Lda6Auy35rS5zODPVFgZ+Rx30fXCOkJwj1gSamWFrzEWcZEe5lJQjCr7XQ1xXHX4f/fr4afUA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727107217; bh=35YJyqQa1pqADAJRbpOcZ8D+lNbcsEteiMgACY7SzIW=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=JglHge+yDVO3idyx9C8YOVt9hG7mccrNhnkE5plnxKRu1oMWWiUFttDph6i6aZG4nONgf2OruweC2pw9Ao7MrOBAodGQH2hvZlija3J8ohGbx7l3Op20W8uHzxwgp6DZQmilWmxBLUz7AGCzBbVNfnxmLUnaAHtzOr683pfgjXoDVL9tAOJp82xzTq83khPbm3C8sZYrtr9zLHByBbwvls6S7Zs0+rMQdngY7bkmKU5DrdzytCe1gQ9qfLdQ5XtnB/9zwgByIKKDKr8c3nUcFqJpiWLfIpF0FX+MpI9yeYgAatL9L4v7I2NHVKAx7ths0UlcYfE0c/yqDGVqPTc07g==
X-YMail-OSG: OYLFMGAVM1kZYN.3iM_5zn8_DOsruRrQ4byyGbfb4Jozmia_03Mjcobgvds.pnY
 IR_a89Szfn4AxDMLq_CzjrA6bq77gdPIVUP_PcKeCPaxufpHcVewazuG7h8MGTjYwfmH63mbgT3h
 1deT5fu44XmvNR3jARwDdn_k_m3gZcrXmdT.F5Y4OPW_Kd7HdUd6yv0I1ZrNoAivtI5uYsMdvOlO
 eNGe0LBWpqkKwBp.64cmJ5hve.F8AtOHwZ27S1fpEE3q_JUP9T.UkQMdDs4EKg3n.Jn6OzJ_z7xy
 ZDHyurRfJ9D4VGvEC9JH2QQIwZ_B1JU.tWQipoXjBuu.5HXYLGM4EempXY5UE9Jd3FWzXGkGLlSj
 GmvwCsVcv6EGJvNMzyKyjLiB9RtO6CeS7OIMFGRU9Fs.7PTIwcm4pqd_aeim_s096Zs.Bf3Pjr4O
 mK6.zohNkPGdoaiCdwC9BSc_x0bybDaOD9RThKnbK_eZJdwJYWrDepZw1y2kUq1ETo3J4aoqw7o.
 4UP5HdC6udXeQrp0TOcNK7SBDAakuZ9awdf4VcNiFYcmbhEPyl28fTkgibSoEGIkMJjX62Hg2DZ_
 oJS43PVrZsItuS4MjPdGBn6etTtQqhTEJvIpFDZHtbINqfoMZgz.VlVF9vlELLhJzFA6DLBxhUiF
 i1i4JqsfSt0_VqX3TIF2KKG1GViS48RDl14cQAk1UG4UYsEBlkPX7XSLkwlpLp5oXU4dXtr_3n6A
 29B7KHBa24sklevs00yUTdWyCn4MZpzDO29hHq0dRkOMBPupDE39_h3vdw7Ksw8drMwEiGWfzKKd
 RqvCYN9OyC3hr82ruFKlOj_5ir908d6PZ4hbtoso4zoZPb8g0oPiddJ8MBMqPT5u3gvT8bEccidW
 EibY1AJsJc4xUS8SEMCOpZb2XRi6f9k4uHqqHcl.l09X0Rk_5jtbpg842i6pzGMW5Sg_JtkVMlme
 zJmTHc2bC5DDScAA368spxEMHw7.SdakU4lKjC7oTU.6kBfcqASwjgVe6ktNsc1tCPMT010OVU0z
 xodVM7fly8eg5LCpgADKacuya9Jk9UVcDbeAm8S2__YV4m4uS497I2dcn7nyF4HtvKceJ3Jmmf8V
 dRzjf7sUD_mZOarSAmlU8oaUKK4vJSuY1qrGNMg2BQmWdeEYSOhBFWeDhblZ31fyPp7.bKhCnlGn
 zj_3_FZfOHYqzDBxTMsEEYCICTo1CWNwOmdO9rQu1dQ7UfD30kOip4.fzETD0Lc6J0Nu.b.xjv8e
 JTmbNutumRCHKLvztmv16xTfReKk4H3W7dlHm.2l6V_O8622YgWku5VA6bahuQMSfZViGeVHtcwa
 z2Mr8Hsd9ayAZPkCpqpJv.FBowN418BJ1dT074RzjfUY6G9MkmN2ZwZ8kRbpvssP1hZsK6O.V878
 Tnhy3jaUvHFIwwBWTTujh0sIUhldBCkb1P2pudnVLv1fdyOVi2cFQqf4TC6rEI.ijy6LbRsxZCSq
 gdTOU9vkcd7Tleryo4sSNGM7sVzpj552M_eA0XKFNG905JpXD6MP0BO3P8rGJMO6Ga3ARuqWiu_T
 AU_ekav0TuG6ANzfmXdzlG8Bd4itaEJ7IxiMlevEjHcDCheaIk0OnSQAw_1_4qlP9niKWLQ3CCF2
 Qke8BHixI.n45eSjOXzKP5weJV0goFF.CqPM6v.cTlgCHQbWrL1eSxxmjMNKe2HagdYA2duf1d6S
 Th1aRejy.AARldfWuXK9OadCuavtEcid7bpDlUD_8M0U9AcaI9S5ybfxRXJO0DryRgb4w3hVZLZg
 eSUNufEWZT4rvZ5dnqkP5N96Esq7QqYkFVLjNP6Mqg4hGKiMDc1v6Lka.ns9CTkiPpouQ2suGDjf
 0rJEEpLbQkJqADszd0Hcibv_KK0mpsKJmBffmWxFbiLwvEJzeOBMHMV9RThbE97vqkjzye03E4QC
 tCUDo5IQnANJ0aJmT4rlzIs_vcNkOwGdgNSlfO67LDQ1cFluA9m4YWtUPg9EsJxhu.8CCI.RXDZO
 IxzlHhRWGHt2kSmB6vSr.k61Ly0HqqfJLVmNpjtEHkPY7KlBVSeQ.l6fYTnZ3RCJ8Mx04pMBrE1Q
 lNV4cJo8c_KpNskQrP1k.8GrZ7INALrdikQgLbYRJ5LLW7XucO8dHNfltxmEIr3e7Tdv95TzEFbu
 n7yCA6i4GnJgIakWCR34qmtogx3pLjW68sXaNhbVvpsr1AWIIq_29TkcG741e8FBh6b1fA08PuMZ
 gbePrGK9GP1DFY_TBtvA5_V2AAcz.dX1OBA--
X-Sonic-MF: <alex_y_xu@yahoo.ca>
X-Sonic-ID: 3d9ce211-70a7-4ce0-bdf8-081fc28b8cac
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Mon, 23 Sep 2024 16:00:17 +0000
Received: by hermes--production-bf1-774ddfff8-ngpsq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 62e3e597125d17114edee27831191129;
          Mon, 23 Sep 2024 15:09:41 +0000 (UTC)
Date: Mon, 23 Sep 2024 11:09:32 -0400
From: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: AMD SME fails boot after "dma-mapping: direct calls for dma-iommu"
To: Leon Romanovsky <leon@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <1727103770.hoytxrqcmg.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
References: <1727103770.hoytxrqcmg.none.ref@localhost>
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi all,

Recently on torvalds master my ASRock B450 Pro4 with Ryzen 1600 cannot=20
boot with mem_encrypt=3Don. Bisect blames "dma-mapping: direct calls for=20
dma-iommu".

Let me know what further information is needed to troubleshoot this=20
issue.

Thanks,
Alex.
