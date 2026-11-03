Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.210.91.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716427;
	b=5HRGt0NwwjJ9vrZpNqR6P0QdqqlvQ3c4OgcCwMpo1v/oOyMMEW6rIPGNggkqg4tqxo4m
	 dY4PMyvkylP8HP9KLrugqdWf70i0PW9YQG9N+rGlx3xK9SWbxEODFGEX3CmCkzHwB6dJR
	 0Qe/A57Sa0hYc4Sj9K7xACO8gKuH3IriomSjwAmN1na5RBzk8+bgiphfo3cskppL0Dqbw
	 5KHgzMrayD5+vasDQcJaOWEZSzrxZy6JNiSLGQjrhcyg08bya0ivBoS8/DJzbjWLt58W5
	 MqLTLyxKciB/S6Cz0Irt3ekRFeMywi2KpTyHpyYyyE6lQOf8BBZNN3dp+6iLnLozwKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716427;
	h=DMARC-Filter:Received:Received:Received:Received:X-OVh-ClientIp:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version:
	 x-ovh-tracer-id:X-VR-SPAMSTATE:X-VR-SPAMSCORE:X-VR-SPAMCAUSE:
	 DKIM-Signature;
	bh=eTPs+DvoE4zLEGX8NqUn0kd9ShkIk3CgigzEPX1cuXg=;
	b=LbTiho0OImBVXcAi82s/9ZpfAxYBEOTsgozihXmM0KXoEm58Fr0xD/25if+QaCRKervg
	 LmosTVqa3c887O2Xs8hm85XDTco9rykoErLhG+t4sTM3DUtoPxhvo/mQo3zOzTOEYvJsx
	 fs9JVMpVPO+fQOkFzAMl53nfH34EcY5zLjx0nBjvuGSV4zdELuzwMzFxiNaztMBUpCa/G
	 92cgmLUtnQbPmbJwnf420yoIZS5ZLt90HXzW25xeTFinvDu5Eh4Jlog0dOizxQOi0btv/
	 1f0ZT6Ik6YExwc6mjorW4jRSX++b4lnY/P+1X+WxaBbOK+s/7CRH0mPQwP8qOvxR28Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=guillain.net;
	spf=pass smtp.mailfrom=guillain.net;
	dkim=pass header.d=guillain.net header.i=@guillain.net header.a=rsa-sha256 header.s=ovhmo31693-selector1 header.b=cFPFtkWt;
	arc=none smtp.remote-ip=51.210.91.13
Received: from smtpout4.mo536.mail-out.ovh.net (smtpout4.mo536.mail-out.ovh.net [51.210.91.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C9C606D835
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 14:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18C9C606D835
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=guillain.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guillain.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=guillain.net header.i=@guillain.net header.a=rsa-sha256 header.s=ovhmo31693-selector1 header.b=cFPFtkWt
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net [79.137.60.221])
	by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4jJrfV71k5z82pw;
	Tue,  3 Nov 2026 14:33:38 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net. [127.0.0.1])
        by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <joro@8bytes.org>; Tue,  3 Nov 2026 14:33:38 +0000 (UTC)
Received: from mta2.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.113.144])
	by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4jJrfV5m1Lz6Mby;
	Tue,  3 Nov 2026 14:33:38 +0000 (UTC)
Received: from guillain.net (unknown [10.1.6.8])
	(Authenticated sender: jean-christophe@guillain.net)
	by mta2.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 0B8F93E2076;
	Tue,  3 Nov 2026 14:33:37 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-95G0014bc1717f-501f-45f5-886f-64cb1d424e43,
                    15838527D7D3E0897ACBD919E55849F771FD37B2) smtp.auth=jean-christophe@guillain.net
X-OVh-ClientIp:78.242.14.240
Message-ID: <aa03a31a5d700da89d2d20ce92a16c9629d20702.camel@guillain.net>
Subject: Re: [REGRESSION] AMD IOMMU NULL pointer dereference during boot
 with v7.4-rc1
From: Jean-Christophe Guillain <jean-christophe@guillain.net>
To: iommu@lists.linux.dev
Cc: vasant.hegde@amd.com, joro@8bytes.org, suravee.suthikulpanit@amd.com
Date: Tue, 03 Nov 2026 15:33:36 +0100
In-Reply-To: <97e7c46b2c3b8a0af2a458649349798c4ecc55ff.camel@guillain.net>
References: <97e7c46b2c3b8a0af2a458649349798c4ecc55ff.camel@guillain.net>
Autocrypt: addr=jean-christophe@guillain.net; prefer-encrypt=mutual;
 keydata=mDMEaEmXaBYJKwYBBAHaRw8BAQdA1qyia8WH1pu6T8sC99WNMyKXooD/SVqJXsJOcnIux
 w20N0plYW4tQ2hyaXN0b3BoZSBHdWlsbGFpbiA8amVhbi1jaHJpc3RvcGhlQGd1aWxsYWluLm5ldD
 6IlgQTFgoAPhYhBDk2+TsBtH9ETCTubi9QTbKhgBdPBQJoSZdoAhsBBQkSzAMABQsJCAcCBhUKCQg
 LAgQWAgMBAh4BAheAAAoJEC9QTbKhgBdPrq0A/icNhFTYLybFWWq1B42UvJLGs18MNRiT5aLdFv3R
 DfHVAQCvzsLrC/qz4rOyIpDzeb0biOu3fiDTcyvV3kPiu3xTDA==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
x-ovh-tracer-id: 17348428717830720510
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGRLeNKNLxg1rwE+di94xOKRcV0GqzRqzJbcf5UYwn48srotUFoNFA+cfN8+Wtc4XXbAuT0naCK8dkSOneDz6zelGrzVq3hCzDPdeqf7UDPkegyx6xds2p/ZHz2+c+y9F1JVFeOc/q8NDO64Yy3Y9AVnJ0K7l2JUowCY21vxlrM/74zxUbj/0jGe6tCaNQEtoA9cMUbjd8J5U9WB4dm0TsdH6YS/wfsGSy7oGtW5VMSqdbIyqMiVy+HMDIgVL20fKc4F0P07FJS8ZjclbRjkkEzlr15L5nMfbAit6GM2WKueWsOrKnODe1PED/8NAqg4Bn3gIbWJQqUhCpKa/koz+sRpRfJfLFZR8fRgna6lJhPFvrELCPYx/sDhokQYBXnEEBSfE5l0WmnzTZdN1pXyT2wvk4yPJimaesnkWZuuwRtVEh6eDu2GhzAw+88ce1ko6vfdhctddeht97dNNMoRW4+GqSLlA4mVZTORmjLK5gDS4Djh6Em0dF9frQDcgv7ru37/OmHxTJR1kQI4CQcIfmJkzUZCeJFkEEJ9eI7Iqqf73YR38jKOS33iRakGhvfrBJo2K4jW/b7lErmX/myknk0XnmfO7sW48ZEpxw74WVnBlleVo18HoxEK7caHRu4vpSuma6f0Gdp4Ylagd1v/7gymVgSW5aWKSwD93d5hNSsPw
DKIM-Signature: a=rsa-sha256; bh=eTPs+DvoE4zLEGX8NqUn0kd9ShkIk3CgigzEPX1cuXg=;
 c=relaxed/relaxed; d=guillain.net; h=From; s=ovhmo31693-selector1;
 t=1793716419; v=1;
 b=cFPFtkWtWVOmoI6kX+B8FuByGTPDuHAdmTLsNhXEYQz2F9Sz54e5UGNNXx71NiZCvdHkTHTf
 aNma6ZhqNk/wZurEsRAlT9TWJDPwPVXFAV8A3TF6csMwsCNdF0DcVbB5kCJbY255J5p6xTjp1Q1
 c5xi4C+dZkwafsKa7g9niMEqZzdVdBhGXu1h54qVpgfQo7cWje7lMu9pIrZ4nglpLdhTiEnzxgP
 gn613LH9xE6DH6IPBdegUsJC3mc3/y28QobpWX/PKhkhZ+aWkteyM9Zwf9xbEqg60uYedHEHUpm
 Ck3JHfyhf8/rTI7b8i66LLMgR89GAIKjqQxmxmDl4+GFw==

Hello again !

I managed to boot 7.4-rc1 successfully with a small patch.

I'm not an experienced kernel developer, so I used an LLM to help me
investigate the crash. The following analysis was suggested by the LLM,
but I tested the proposed change myself on the affected machine.

The likely culprit is commit bf5bdfd1f8d4 ("iommu/amd: Force identity
mode for selected GPUs only").

This commit introduced the following line in
quirks_force_identity_mapping():

if (pci_upstream_bridge(pdev)->vendor =3D=3D PCI_VENDOR_ID_ATI)
    return false;

According to the analysis, pci_upstream_bridge(pdev) can return NULL
when a PCI device has no upstream bridge. In that case, accessing -
>vendor causes a NULL pointer dereference.

This seems consistent with the original oops:

RIP: amd_iommu_def_domain_type+0x73/0xb0
RAX: 0000000000000000
CR2: 000000000000003c

The LLM suggested checking the returned pointer before dereferencing
it.

I applied the following change to v7.4-rc1:

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 960e1dc05ec6..75e98e2e9d83 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3372,6 +3372,7 @@ static bool amd_iommu_is_attach_deferred(struct
device *dev)

 static bool quirks_force_identity_mapping(struct pci_dev *pdev)
 {
+       struct pci_dev *bridge;
        int class =3D pdev->class >> 8;

        /* AMD GPU vendor ID */
@@ -3383,7 +3384,8 @@ static bool quirks_force_identity_mapping(struct
pci_dev *pdev)
            class !=3D PCI_CLASS_DISPLAY_OTHER)
                return false;

-       if (pci_upstream_bridge(pdev)->vendor =3D=3D PCI_VENDOR_ID_ATI)
+       bridge =3D pci_upstream_bridge(pdev);
+       if (bridge && bridge->vendor =3D=3D PCI_VENDOR_ID_ATI)
                return false;

        /* It is the GPU in an APU, force identity domain */

With this patch, the system boots successfully without amd_iommu=3Doff.

dmesg shows that the AMD IOMMU is initialized :

iommu: Default domain type: Translated
AMD-Vi: Interrupt remapping enabled
AMD-Vi: Virtual APIC enabled
perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
amdgpu 0000:00:01.0: AMD-Vi: PerfOpt armed on IOMMU0

So the patch fixes the boot regression on my hardware while keeping AMD
IOMMU enabled.

I cannot tell whether this is the correct fix for all affected systems,
but I hope these findings will be useful.

Cheers !
Jean-Christophe Guillain
