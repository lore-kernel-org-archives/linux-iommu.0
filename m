Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3905C433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 16:39:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DD2B841B3;
	Tue, 15 Mar 2022 16:39:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ohIEnh9efup; Tue, 15 Mar 2022 16:39:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3CC1284187;
	Tue, 15 Mar 2022 16:39:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CC3BC001A;
	Tue, 15 Mar 2022 16:39:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BCB7C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 16:39:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5E95403A2
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 16:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jT9wqLJ4A0Oj for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 16:39:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1CC2E40012
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 16:39:34 +0000 (UTC)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FGPEvF029511; 
 Tue, 15 Mar 2022 16:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=86aL+xbwdE1jgnOidVY4JgtAIE9bJ2Wd34ptqVKlogo=;
 b=BCG0f1Q12c1R85DRkjPGeZ+FTiyyDAir1dVi/qiNF20mpbbwYXkPm+FoE9bq3aRUaMUf
 X2wuJzcvd8sLNKIQipm6kCwdndDWV4LzAXEuCqU67xkSAVa5oIBsUHQezvuY+zBd9nmh
 eRGvbjq3uKQgVdz/8J768mZCyWGH3fNr0CJwoLFBiU5yi3BdkWzZ5xN+GnzI4+xOf5vB
 I25fZlFE+04vYoec8Q3Sg7LohQTgUp8RcTE5i+4IshU5oDe5ukmHVevOpbA9IVuGxvtX
 stYv2pGXXB3lA9N5TtCBZCYK+VgEHr+klT4UkoSpngstJNyqPEcPTPj5yO3AYV14KOrk SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3etxa28dbk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Mar 2022 16:39:30 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22FGPjNs012271;
 Tue, 15 Mar 2022 16:39:29 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3etxa28dax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Mar 2022 16:39:28 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22FGR9Mo019322;
 Tue, 15 Mar 2022 16:39:27 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma02wdc.us.ibm.com with ESMTP id 3erk59ps5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Mar 2022 16:39:27 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22FGdP3Q27853244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Mar 2022 16:39:25 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5F6DAC06A;
 Tue, 15 Mar 2022 16:39:25 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E478AAC066;
 Tue, 15 Mar 2022 16:39:14 +0000 (GMT)
Received: from [9.211.32.184] (unknown [9.211.32.184])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 15 Mar 2022 16:39:14 +0000 (GMT)
Message-ID: <3cc6dff9-0346-c449-249f-5812b3df379c@linux.ibm.com>
Date: Tue, 15 Mar 2022 12:39:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4 22/32] KVM: s390: pci: routines for (dis)associating
 zPCI devices with a KVM
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
 <20220314194451.58266-23-mjrosato@linux.ibm.com>
 <20220314214633.GJ11336@nvidia.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20220314214633.GJ11336@nvidia.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iSDqed2p1r28JmWsOMYySAiM5fB1UvOT
X-Proofpoint-ORIG-GUID: xNu_0DWt1lKw2zQUPUBiiledYjR3anGK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_07,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150103
Cc: kvm@vger.kernel.org, david@redhat.com, thuth@redhat.com,
 linux-kernel@vger.kernel.org, vneethv@linux.ibm.com, agordeev@linux.ibm.com,
 imbrenda@linux.ibm.com, will@kernel.org, linux-s390@vger.kernel.org,
 frankja@linux.ibm.com, corbet@lwn.net, linux-doc@vger.kernel.org,
 pasic@linux.ibm.com, gerald.schaefer@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, gor@linux.ibm.com, schnelle@linux.ibm.com,
 hca@linux.ibm.com, alex.williamson@redhat.com, freude@linux.ibm.com,
 pmorel@linux.ibm.com, cohuck@redhat.com, oberpar@linux.ibm.com,
 iommu@lists.linux-foundation.org, svens@linux.ibm.com, pbonzini@redhat.com
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

On 3/14/22 5:46 PM, Jason Gunthorpe wrote:
> On Mon, Mar 14, 2022 at 03:44:41PM -0400, Matthew Rosato wrote:
>> +int kvm_s390_pci_zpci_start(struct kvm *kvm, struct zpci_dev *zdev)
>> +{
>> +	struct vfio_device *vdev;
>> +	struct pci_dev *pdev;
>> +	int rc;
>> +
>> +	rc = kvm_s390_pci_dev_open(zdev);
>> +	if (rc)
>> +		return rc;
>> +
>> +	pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
>> +	if (!pdev) {
>> +		rc = -ENODEV;
>> +		goto exit_err;
>> +	}
>> +
>> +	vdev = get_vdev(&pdev->dev);
>> +	if (!vdev) {
>> +		pci_dev_put(pdev);
>> +		rc = -ENODEV;
>> +		goto exit_err;
>> +	}
>> +
>> +	zdev->kzdev->nb.notifier_call = kvm_s390_pci_group_notifier;
>> +
>> +	/*
>> +	 * At this point, a KVM should already be associated with this device,
>> +	 * so registering the notifier now should immediately trigger the
>> +	 * event.  We also want to know if the KVM association is later removed
>> +	 * to ensure proper cleanup happens.
>> +	 */
>> +	rc = register_notifier(vdev->dev, &zdev->kzdev->nb);
>> +
>> +	put_vdev(vdev);
>> +	pci_dev_put(pdev);
>> +
>> +	/* Make sure the registered KVM matches the KVM issuing the ioctl */
>> +	if (rc || zdev->kzdev->kvm != kvm) {
>> +		rc = -ENODEV;
>> +		goto exit_err;
>> +	}
>> +
>> +	/* Must support KVM-managed IOMMU to proceed */
>> +	if (IS_ENABLED(CONFIG_S390_KVM_IOMMU))
>> +		rc = zpci_iommu_attach_kvm(zdev, kvm);
>> +	else
>> +		rc = -EINVAL;
> 
> This seems like kind of a strange API, shouldn't kvm be getting a
> reference on the underlying iommu_domain and then calling into it to
> get the mapping table instead of pushing KVM specific logic into the
> iommu driver?
> 
> I would be nice if all the special kvm stuff could more isolated in
> kvm code.
> 
> I'm still a little unclear about why this is so complicated - can't
> you get the iommu_domain from the group FD directly in KVM code as
> power does?

Yeah, I think I could do something like that using the vfio group fd 
like power does.

Providing a reference to the kvm itself inside iommu was being used for 
the pin/unpin operations, which would not be necessary if we switched to 
the 1st layer iommu pinning all of guest memory.



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
