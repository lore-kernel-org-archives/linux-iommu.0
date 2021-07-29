Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7AAC4338F
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 09:51:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226D7603E7
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 09:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 226D7603E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A7B21401BD;
	Thu, 29 Jul 2021 09:51:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ssYxcza-1lxS; Thu, 29 Jul 2021 09:51:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C1E234048D;
	Thu, 29 Jul 2021 09:51:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3819C0027;
	Thu, 29 Jul 2021 09:51:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CBACC000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 05:05:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 261FF6068B
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 05:05:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kxgx7Zgu7Web for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 05:05:56 +0000 (UTC)
X-Greylist: delayed 00:44:05 by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D27DA60634
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 05:05:55 +0000 (UTC)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16T4FEtZ182812; Thu, 29 Jul 2021 00:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=lhTVW3t0lTF5kza0RELN9IffV7THs5vCoJtihBxvY3w=;
 b=GJzzg3zwiEa86QHC6SaV8sCDIKmHuyJntUFheqCQd74yNm+fsSZR/BWlUhDB+cUo762t
 GtNvpdTtxsnrgJOvyG0ZXWtim0ub84I3gz1cto8zKp+BhlhQ06tiTty3f62/N7MND2du
 e2RYiTdRV5hVbCwLKCj0gwtxoK04kgXvX/8di0wlf9M8kZ0N2UlymFDyvMo7gFflGjwG
 h6ZthjWZoWP6SxypOGh2A7R6GtgntNemWim28v1WN87cKKnWEBUPZE8gIhgLyTvrfOcS
 bJCUZNzGOC131DlyDGY87vEFWmlqyr2odiemd4bhyK6W4Z2rWp53fcnSQQ5cK+2etZRY Bg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3a3n4y8483-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jul 2021 00:21:45 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16T4D5kg007046;
 Thu, 29 Jul 2021 04:21:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06ams.nl.ibm.com with ESMTP id 3a235khen5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jul 2021 04:21:43 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 16T4LffY25559496
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jul 2021 04:21:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 029BEA405B;
 Thu, 29 Jul 2021 04:21:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22762A4062;
 Thu, 29 Jul 2021 04:21:38 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.126.126])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jul 2021 04:21:37 +0000 (GMT)
Subject: Re: [powerpc][next-20210727] Boot failure - kernel BUG at
 arch/powerpc/kernel/interrupt.c:98!
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <YQGVZnMe9hFieF8D@Ryzen-9-3900X.localdomain>
Date: Thu, 29 Jul 2021 09:51:36 +0530
Message-Id: <63F21E55-B11E-4B30-B436-C063C405D9C5@linux.vnet.ibm.com>
References: <1905CD70-7656-42AE-99E2-A31FC3812EAC@linux.vnet.ibm.com>
 <YQGVZnMe9hFieF8D@Ryzen-9-3900X.localdomain>
To: Nathan Chancellor <nathan@kernel.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TmBeoEqtp6gufjRfjgGV6pBLwHd7ZQEp
X-Proofpoint-ORIG-GUID: TmBeoEqtp6gufjRfjgGV6pBLwHd7ZQEp
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-07-29_03:2021-07-27,
 2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 clxscore=1011 mlxlogscore=768 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290024
X-Mailman-Approved-At: Thu, 29 Jul 2021 09:51:07 +0000
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-next@vger.kernel.org,
 Claire Chang <tientzu@chromium.org>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Cgo+IE9uIDI4LUp1bC0yMDIxLCBhdCAxMTowNSBQTSwgTmF0aGFuIENoYW5jZWxsb3IgPG5hdGhh
bkBrZXJuZWwub3JnPiB3cm90ZToKPiAKPiBPbiBXZWQsIEp1bCAyOCwgMjAyMSBhdCAwMTozMTow
NlBNICswNTMwLCBTYWNoaW4gU2FudCB3cm90ZToKPj4gbGludXgtbmV4dCBmYWlscyB0byBib290
IG9uIFBvd2VyIHNlcnZlciAoUE9XRVI4L1BPV0VSOSkuIEZvbGxvd2luZyB0cmFjZXMKPj4gYXJl
IHNlZW4gZHVyaW5nIGJvb3QKPj4gCj4+IFsgICAgMC4wMTA3OTldIHNvZnR3YXJlIElPIFRMQjog
dGVhcmluZyBkb3duIGRlZmF1bHQgbWVtb3J5IHBvb2wKPj4gWyAgICAwLjAxMDgwNV0gLS0tLS0t
LS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tCj4+IFsgICAgMC4wMTA4MDhdIGtlcm5lbCBC
VUcgYXQgYXJjaC9wb3dlcnBjL2tlcm5lbC9pbnRlcnJ1cHQuYzo5OCEKPj4gWyAgICAwLjAxMDgx
Ml0gT29wczogRXhjZXB0aW9uIGluIGtlcm5lbCBtb2RlLCBzaWc6IDUgWyMxXQrigKbigKYuCj4g
Cj4gSSBub3RpY2VkIHRoaXMgd2l0aCBPcGVuU1VTRSdzIHBwYzY0bGUgY29uZmlnIFsxXSBhbmQg
bXkgYmlzZWN0IGxhbmRlZCBvbgo+IGNvbW1pdCBhZDZjMDAyODMxNjMgKCJzd2lvdGxiOiBGcmVl
IHRibCBtZW1vcnkgaW4gc3dpb3RsYl9leGl0KCkiKS4gVGhhdAoKSW5kZWVkLiBUaGFua3MgTmF0
aGFuLgpCaXNlY3QgcG9pbnRzIHRvIHRoaXMgY29tbWl0LiAgUmV2ZXJ0aW5nIHRoZSBjb21taXQg
YWxsb3dzIHRoZSBrZXJuZWwgdG8gYm9vdC4KClRoYW5rcwotU2FjaGluCgo+IHNlcmllcyBqdXN0
IGtlZXBzIG9uIGdpdmluZy4uLiBBZGRpbmcgc29tZSBwZW9wbGUgZnJvbSB0aGF0IHRocmVhZCB0
bwo+IHRoaXMgb25lLiBPcmlnaW5hbCB0aHJlYWQ6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
ci8xOTA1Q0Q3MC03NjU2LTQyQUUtOTlFMi1BMzFGQzM4MTJFQUNAbGludXgudm5ldC5pYm0uY29t
Lwo+IAo+IFsxXTogaHR0cHM6Ly9naXRodWIuY29tL29wZW5TVVNFL2tlcm5lbC1zb3VyY2UvcmF3
L21hc3Rlci9jb25maWcvcHBjNjRsZS9kZWZhdWx0Cj4gCj4gQ2hlZXJzLAo+IE5hdGhhbgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
