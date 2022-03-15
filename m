Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47591C433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 16:29:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E0E2B40414;
	Tue, 15 Mar 2022 16:29:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OYO_quUvJuDN; Tue, 15 Mar 2022 16:29:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1ADB440012;
	Tue, 15 Mar 2022 16:29:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E39FBC001A;
	Tue, 15 Mar 2022 16:29:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 096F6C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 16:29:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EC41F842F2
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 16:29:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x7Ko7fmWOUWR for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 16:29:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A2CD4842B9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 16:29:23 +0000 (UTC)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FGEM4Y029688; 
 Tue, 15 Mar 2022 16:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cbkYVQbQRRtLfFZ4wdGkiRutFnpOquBvZJYoshzzZi4=;
 b=caTfq98QMeGQf248z9VAEzG1kRAcOYKzm+X1QOZ5FmuJtUaEx+k71YYYAk1Wz/FgIs4+
 YRKcQSi26TjPnDq5zu+/6QTTt0FrN8brPa1+p/5DGaP575dA+oaBTKybXXhm8Mibft+F
 qYqrSQ2o2k1UKco4FK8nJA9lkEiMG4mM8gcCHm6LAOV4z1CRBfQlrHXtefLglzKEdzHx
 btiTfqQucAH9RE/q8SKADdWYcfLVJELHfwGlPZgQKAEn41AJqzjW0W3y1dzSLD3D9RGI
 pcGyDmwAPx135bzu91zAVrKoK1VyNue49E3vA8BHroMDjsy63McaODciBVrDNuyMlGD4 +A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3etw7p24wv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Mar 2022 16:29:18 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22FGEw13007435;
 Tue, 15 Mar 2022 16:29:18 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3etw7p24wm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Mar 2022 16:29:18 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22FGRDhn009206;
 Tue, 15 Mar 2022 16:29:17 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma04wdc.us.ibm.com with ESMTP id 3erk59pkqa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Mar 2022 16:29:17 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22FGTFtc25297208
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Mar 2022 16:29:15 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2482AC06D;
 Tue, 15 Mar 2022 16:29:15 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8898FAC05E;
 Tue, 15 Mar 2022 16:29:04 +0000 (GMT)
Received: from [9.211.32.184] (unknown [9.211.32.184])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 15 Mar 2022 16:29:04 +0000 (GMT)
Message-ID: <5a1c64ac-df10-fb66-ad6d-39adf786f32b@linux.ibm.com>
Date: Tue, 15 Mar 2022 12:29:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4 15/32] vfio: introduce KVM-owned IOMMU type
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, borntraeger@linux.ibm.com
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
 <20220314194451.58266-16-mjrosato@linux.ibm.com>
 <20220314213808.GI11336@nvidia.com>
 <decc5320-eb3e-af25-fd2b-77fabe56a897@linux.ibm.com>
 <20220315143858.GY11336@nvidia.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20220315143858.GY11336@nvidia.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XovYpnHnN8X7XvZsXcj1wbC8jRUcunWF
X-Proofpoint-GUID: VyCBJft7M62L1ZwToTemOEV0VPlk6L0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_03,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150102
Cc: kvm@vger.kernel.org, david@redhat.com, thuth@redhat.com,
 linux-kernel@vger.kernel.org, vneethv@linux.ibm.com, agordeev@linux.ibm.com,
 imbrenda@linux.ibm.com, will@kernel.org, linux-s390@vger.kernel.org,
 frankja@linux.ibm.com, corbet@lwn.net, linux-doc@vger.kernel.org,
 pasic@linux.ibm.com, gerald.schaefer@linux.ibm.com, farman@linux.ibm.com,
 gor@linux.ibm.com, schnelle@linux.ibm.com, hca@linux.ibm.com,
 alex.williamson@redhat.com, freude@linux.ibm.com, pmorel@linux.ibm.com,
 cohuck@redhat.com, oberpar@linux.ibm.com, iommu@lists.linux-foundation.org,
 svens@linux.ibm.com, pbonzini@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 3/15/22 10:38 AM, Jason Gunthorpe wrote:
> On Tue, Mar 15, 2022 at 09:49:01AM -0400, Matthew Rosato wrote:
> 
>> The rationale for splitting steps 1 and 2 are that VFIO_SET_IOMMU doesn't
>> have a mechanism for specifying more than the type as an arg, no?  Otherwise
>> yes, you could specify a kvm fd at this point and it would have some other
>> advantages (e.g. skip notifier).  But we still can't use the IOMMU for
>> mapping until step 3.
> 
> Stuff like this is why I'd be much happier if this could join our
> iommfd project so we can have clean modeling of the multiple iommu_domains.
> 

I'd certainly be willing to collaborate so feel free to loop me in on 
the discussions; but I got the impression that iommufd is not close to 
ready (maybe I'm wrong?) -- if so I really don't want to completely 
delay this zPCI support behind it as it has a significant benefit for 
kvm guests on s390x :(

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
