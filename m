Received: from out198-18.us.a.mail.aliyun.com (out198-18.us.a.mail.aliyun.com [47.90.198.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822C93ACA5D
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802878; cv=none; b=K5TfoAoN76yHCW3AhXSIiDV1D8W3RLPtmpha91lWq8fwtlzWcs0PDcU/7skvKvK70d7n1Q+5+7xL/3DkwdqhTR5XzpYWWUP6wKKp0G5iVcobEmIocdXfZP8fCmWqaYq0/YCLsDwaFh4V0PERE/6TxYXTtRxadHz81AupNPUrtTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802878; c=relaxed/simple;
	bh=BzkrpQVdiIEv90Un5q9B8QK7ddJH5pVmlKLuBKxUtCk=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=NHja7+6nZKLT55YeeA6iqVmb+LoMIH1UsFsS8fcwwxzhjwrT8fVHpVZ8N55X7vE6YKAk+AL31YL8yUrZWD7U1BPDIdDhDCZtsysgAgL0gA3w8SNejrgZ6US2py4kBHdcA12xCMcHN+Jj2ccHQi8Rr3SFFdtHgKf5IImdH8AaHEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1058612|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0101922-0.000622925-0.989185;FP=3403972384492404811|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=xuyongwei@open-hieco.net;NM=1;PH=DW;RN=12;RT=12;SR=0;TI=W4_0.2.3_v5ForWebDing_212027AA_1779801869958_o7001c195u;
Received: from WS-web (xuyongwei@open-hieco.net[W4_0.2.3_v5ForWebDing_212027AA_1779801869958_o7001c195u] cluster:ay29) at Tue, 26 May 2026 21:40:52 +0800
Date: Tue, 26 May 2026 21:40:52 +0800
From: "=?UTF-8?B?5b6Q5YuH5Lyf?=" <xuyongwei@open-hieco.net>
To: "Vasant Hegde" <vasant.hegde@amd.com>,
  "=?UTF-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>,
  "suravee.suthikulpanit" <suravee.suthikulpanit@amd.com>
Cc: "Wei Wang" <wei.w.wang@hotmail.com>,
  "will" <will@kernel.org>,
  "robin.murphy" <robin.murphy@arm.com>,
  "thomas.lendacky" <thomas.lendacky@amd.com>,
  "aik" <aik@amd.com>,
  "jgg" <jgg@nvidia.com>,
  "kevin.tian" <kevin.tian@intel.com>,
  "iommu" <iommu@lists.linux.dev>,
  "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "=?UTF-8?B?5b6Q5YuH5Lyf?=" <xuyongwei@open-hieco.net>
Message-ID: <1bcebcdb-8d77-453c-a0c8-8e6bac490ce4.xuyongwei@open-hieco.net>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MSAwLzNdIGlvbW11L2FtZDogRml4IGFuZCBpbXByb3ZlIFNCIElPQVBJ?=
  =?UTF-8?B?QyBJVlJTIHZhbGlkYXRpb24=?=
X-Mailer: [Alimail-Mailagent revision 296][W4_0.2.3][v5ForWebDing][Chrome]
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <SI2PR01MB4393DCD4BF7E79CB63066D16DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com> <ui2oa3gdlq6v3qfsezadn7rxa7osisjmag7us5ufw2k6mn75gr@mzilog72gwf2>,<a9e17e1e-8ff9-4dc8-99b2-37bde23755d5@amd.com>
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_SFRTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzE0OC4wLjAuMCBTYWZhcmkvNTM3LjM2IEVkZy8xNDguMC4wLjA=Ch
In-Reply-To: <a9e17e1e-8ff9-4dc8-99b2-37bde23755d5@amd.com>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gNS8xOC8yMDI2IDE6NTUgQU0gVmFzYW50IEhlZ2RlIHdyb3RlOgo+Sm9lcmcsCj4KPgo+T24g
NS8xMS8yMDI2IDE6MTAgUE0sIErDtnJnIFLDtmRlbCB3cm90ZToKPj4gU3VyYXZlZSwgVmFzYW50
LCBjb3VsZCB5b3UgcGxlYXNlIGhhdmUgYSBsb29rIGF0IHRoaXMgc2VyaWVzPwo+Cj5TdXJlLiBX
ZSBhcmUgdGVzdGluZyBpdCBpbnRlcm5hbGx5LiBXZSB3aWxsIHJlc3BvbmQgYmFjayB0aGlzIHdl
ZWsuCj4KPi1WYXNhbnQKClRlc3RlZC1ieTogWW9uZ3dlaSBYdSA8eHV5b25nd2VpQG9wZW4taGll
Y28ubmV0PgoKSSBhbHNvIHRlc3RlZCB0aGUgcGF0Y2hzZXQgb24gSHlnb24gR2VuIDQgKDc0OTAp
IGFuZCBBTUQgR2Vub2EgU2VydmVycy4gCgpPbiBIeWdvbiA3NDkwOgpXaXRob3V0IHRoaXMgcGF0
Y2g6IFdoZW4gdGhlIGhvc3QgYm9vdHMsIGRtZXNnIHNob3dzIGludGVycnVwdCByZW1hcHBpbmcg
aXMgZGlzYWJsZWQgZHVlIHRvIHRoZSBmYWlsdXJlIHRvIGZpbmQgdGhlIFNCIElPQVBJQzoKWyAg
ICA4Ljg3MTY0OV0gQU1ELVZpOiBbRmlybXdhcmUgQnVnXTogOiBObyBzb3V0aGJyaWRnZSBJT0FQ
SUMgZm91bmQKWyAgICA4Ljg3MTY1M10gQU1ELVZpOiBEaXNhYmxpbmcgaW50ZXJydXB0IHJlbWFw
cGluZwpbICAgIDguODcyMjM2XSB4MmFwaWM6IElSUSByZW1hcHBpbmcgZG9lc24ndCBzdXBwb3J0
IFgyQVBJQyBtb2RlClsgICAgOC44NzIyNDFdIHgyYXBpYyBkaXNhYmxlZAoKV2l0aCB0aGlzIHBh
dGNoc2V0IGFwcGxpZWQ6IFdoZW4gdGhlIGhvc3QgYm9vdHMsIGRtZXNnIHNob3dzIHRoZSBBUElD
IGFuZCBpbnRlcnJ1cHQgcmVtYXBwaW5nIGFyZSBzdWNjZXNzZnVsbHkgZW5hYmxlZDoKWyAgIDE1
Ljc5NTYzNF0gQU1ELVZpOiBJbnRlcnJ1cHQgcmVtYXBwaW5nIGVuYWJsZWQKWyAgIDE1Ljc5NTYz
OV0gQU1ELVZpOiBYMkFQSUMgZW5hYmxlZApbICAgMTUuODAyMTEyXSBBTUQtVmk6IFZpcnR1YWwg
QVBJQyBlbmFibGVkCgpPbiBBTUQgR2Vub2EgU2VydmVyOgpXaXRoIHRoaXMgcGF0Y2hzZXQgYXBw
bGllZCwgdGhlIGhvc3QgYm9vdHMgY29ycmVjdGx5IHdpdGggaW50ZXJydXB0IHJlbWFwcGluZyBl
bmFibGVkLiBBIFZNIHdhcyBsYXVuY2hlZCBhbmQgcmFuIG5vcm1hbGx5LiBObyByZWdyZXNzaW9u
cyB3ZXJlIG9ic2VydmVkLgoK
