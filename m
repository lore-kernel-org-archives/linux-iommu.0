Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1EE13C914
	for <iommu@lists.linux.dev>; Fri,  2 Aug 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722609496; cv=none; b=pJmfIbQ02i5iKKvr750anXFvx9kk52JvVHslO6Fw0OtNCrlLdCHXl8ZFVeBu/eClQpPTig0wSDw/1KyGR+e0KDpWChPwqQLk35DpCqr+Ic7WN2NJKxwjnoUZBZP8m4aA5C+s4rW5NJOo2LP5WyirkeNHpIf6NkJW0xxdvSanBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722609496; c=relaxed/simple;
	bh=pkqcA5LK0400rLcyCE2ryxk95nAKuPeu8OIfADIUa7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSso8K7Rt0R2C6enpFHHssjtFUxIKdU0htY2vvfad7K1bLj7fNM5E5COpKn1yf5B1Vv5lu9hB6pAUd3wUFRZ+6AFJHejPXoeSQloc7L3DKJKhSvFCiVa/GKa3ojwtvCGs3/xdBKyS9dG7Ozq9emKOk9pUZAyFpCkA2H0O4y/Lwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fsrBp9P+; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fsrBp9P+"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4518d9fa2f4so213891cf.0
        for <iommu@lists.linux.dev>; Fri, 02 Aug 2024 07:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722609494; x=1723214294; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJ1w676lyRitu5n+ttNnwmnBtIQ3ITSfQGGvzmkYU4Q=;
        b=fsrBp9P+21P6UD+kJnU998ik9fd5tMSOe8nmH0RFHZqbjl9+KMyJddx8KFl4uk2vG3
         E/qq4W5cqNnyhRQfZwk9LDKT2L+IjIsMCZc59AwBUawoiQkN2RViy5mqOWaVv9pI2QC0
         hgZUB5oCgSYeKerK49g6SyJUhYvRSgrEYZNIfaszTL5p7YPnvblTKZegV3rU0I1C40yp
         OL2IMkJLoHrdeM4tYP+16gVtDb40s9Usd++618Xx9XdHe1oBI50y7ZQsDnnS+DaTOrTC
         8c+Z/jiMfUvIxlydhY0Ro3u99ncIN8206U7WUOqjpmHLUOrrQlXCu/KqKaWyn/qRiWvh
         kgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722609494; x=1723214294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJ1w676lyRitu5n+ttNnwmnBtIQ3ITSfQGGvzmkYU4Q=;
        b=NIagrYGO8eU2momsRIoVuj6NgznJTYyQnXXdlZhDChPS7JpfVPcQntyR1LoEQBGxml
         4BoYtELjsC3VSLUGd1Z3yhCtkYbfU70hohqB7xbCd0t9vS3of13zDWEogJ2Uk5gpghfq
         x6OdFLE7AYvHIqmdE9+Chln2Ptzpgxu/edTqs/9dy81O2T4h3rULW53b/TZIXeJzQQ/G
         mST6k5cqiOHyAhEWyZ6ZMNGhS1kp68RPZA0lA4Cq/VrwgT/V1TkoQoSmQimvDVhKKIhS
         yHKAV3rd4dYLY1K2NO/DVW6OWivg41K2KQ62pI3QdW9JjkDEebfjvsDbpISdAIO+uvwq
         jt3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQov509kuLSssw65TvyTGQtO5q+45XLnWke1U9u8ojz/mKVmilohz4+8tXOzV/HJVdMJ53Blk/Ty25pkiVHJTcBeOpWqg=
X-Gm-Message-State: AOJu0YwwL+tgusWjnx2EbVp6p8aHDClYG6JxZToc7EpxL+qWH9b+r5Tj
	5esHjdbdcQ40k8MWYB/n0DRn1PKVYEVimGe8bmFZdead1d7vBuEXQJm8va+QAIy1TU8ibgL/x/B
	jFL6UtGQhor13wRMc/pEf8BCxyqH3hCEk2laV
X-Google-Smtp-Source: AGHT+IH7hzQHgUKPzViDAoxbPxbSBxmbKB+vgkj7oLy1VUPgEnl3qfo5lMXhH0aHwRK1t2mSH4p+yolpSGLeieZLV/E=
X-Received: by 2002:ac8:5786:0:b0:44f:ee20:d189 with SMTP id
 d75a77b69052e-4518c6eef94mr2770331cf.8.1722609493552; Fri, 02 Aug 2024
 07:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
 <7d5a8b86-6f0d-50ef-1b2f-9907e447c9fc@huawei.com> <20240724102417.GA27376@willie-the-truck>
 <c2f6163e-47f0-4dce-b077-7751816be62f@linux.intel.com>
In-Reply-To: <c2f6163e-47f0-4dce-b077-7751816be62f@linux.intel.com>
From: Pranjal Shrivastava <praan@google.com>
Date: Fri, 2 Aug 2024 20:08:01 +0530
Message-ID: <CAN6iL-QvE29-t4B+Ucg+AYMPhr9cqDa8xGj9oz_MAO5uyZyX2g@mail.gmail.com>
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some scenarios
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Kunkun Jiang <jiangkunkun@huawei.com>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, Michael Shavit <mshavit@google.com>, 
	Mostafa Saleh <smostafa@google.com>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com, 
	yuzenghui@huawei.com, tangnianyao@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,
On Mon, Jul 29, 2024 at 11:02=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com=
> wrote:
>
> On 2024/7/24 18:24, Will Deacon wrote:
> > On Wed, Jul 24, 2024 at 05:22:59PM +0800, Kunkun Jiang wrote:
> >> On 2024/7/24 9:42, Kunkun Jiang wrote:
> >>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> >>> 1797                 while (!queue_remove_raw(q, evt)) {
> >>> 1798                         u8 id =3D FIELD_GET(EVTQ_0_ID, evt[0]);
> >>> 1799
> >>> 1800                         ret =3D arm_smmu_handle_evt(smmu, evt);
> >>> 1801                         if (!ret || !__ratelimit(&rs))
> >>> 1802                                 continue;
> >>> 1803
> >>> 1804                         dev_info(smmu->dev, "event 0x%02x
> >>> received:\n", id);
> >>> 1805                         for (i =3D 0; i < ARRAY_SIZE(evt); ++i)
> >>> 1806                                 dev_info(smmu->dev, "\t0x%016llx=
\n",
> >>> 1807                                          (unsigned long
> >>> long)evt[i]);
> >>> 1808
> >>> 1809                         cond_resched();
> >>> 1810                 }
> >>>
> >>> The smmu-v3 driver cannot print event information when "ret" is 0.
> >>> Unfortunately due to commit 3dfa64aecbaf
> >>> ("iommu: Make iommu_report_device_fault() return void"), the default
> >>> return value in arm_smmu_handle_evt() is 0. Maybe a trace should
> >>> be added here?
> >> Additional explanation. Background introduction:
> >> 1.A device(VF) is passthrough(VFIO-PCI) to a VM.
> >> 2.The SMMU has the stall feature.
> >> 3.Modified guest device driver to generate an event.
> >>
> >> This event handling process is as follows:
> >> arm_smmu_evtq_thread
> >>      ret =3D arm_smmu_handle_evt
> >>          iommu_report_device_fault
> >>              iopf_param =3D iopf_get_dev_fault_param(dev);
> >>              // iopf is not enabled.
> >> // No RESUME will be sent!
> >>              if (WARN_ON(!iopf_param))
> >>                  return;
> >>      if (!ret || !__ratelimit(&rs))
> >>          continue;
> >>
> >> In this scenario, the io page-fault capability is not enabled.
> >> There are two problems here:
> >> 1. The event information is not printed.
> >> 2. The entire device(PF level) is stalled,not just the current
> >> VF. This affects other normal VFs.
> > Oh, so that stall is probably also due to b554e396e51c ("iommu: Make
> > iopf_group_response() return void"). I agree that we need a way to
> > propagate error handling back to the driver in the case that
> > 'iopf_param' is NULL, otherwise we're making the unexpected fault
> > considerably more problematic than it needs to be.
> >
> > Lu -- can we add the -ENODEV return back in the case that
> > iommu_report_device_fault() doesn't even find a 'iommu_fault_param' for
> > the device?
>
> Yes, of course. The commit b554e396e51c was added to consolidate the
> drivers' auto response code in the core with the assumption that driver
> only needs to call iommu_report_device_fault() for reporting an iopf.
>

I had a go at taking Jason's diff and implementing the suggestions in
this thread.
Kunkun -- please can you see if this fixes the problem for you?
Lu -- it looks like the intel ->page_response callback doesn't expect
a NULL event
pointer, so for now I return immediately in that case as we did in v6.7.

> Thanks,
> baolu
>

Thanks,
Pranjal

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a31460f9f3d4..ed2b106e02dd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1777,7 +1777,7 @@ static int arm_smmu_handle_evt(struct
arm_smmu_device *smmu, u64 *evt)
  goto out_unlock;
  }

- iommu_report_device_fault(master->dev, &fault_evt);
+ ret =3D iommu_report_device_fault(master->dev, &fault_evt);
 out_unlock:
  mutex_unlock(&smmu->streams_mutex);
  return ret;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 0e3a9b38bef2..7684e7562584 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -532,6 +532,9 @@ void intel_svm_page_response(struct device *dev,
struct iopf_fault *evt,
  bool last_page;
  u16 sid;

+ if (!evt)
+ return;
+
  prm =3D &evt->fault.prm;
  sid =3D PCI_DEVID(bus, devfn);
  pasid_present =3D prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 7c9011992d3f..0c3b2125563e 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -113,6 +113,57 @@ static struct iopf_group *iopf_group_alloc(struct
iommu_fault_param *iopf_param,
  return group;
 }

+static struct iommu_attach_handle *find_fault_handler(struct device *dev,
+                                                     struct iopf_fault *ev=
t)
+{
+       struct iommu_fault *fault =3D &evt->fault;
+       struct iommu_attach_handle *attach_handle;
+
+       if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
+               attach_handle =3D iommu_attach_handle_get(dev->iommu_group,
+                                                       fault->prm.pasid, 0=
);
+               if (IS_ERR(attach_handle)) {
+                       const struct iommu_ops *ops =3D dev_iommu_ops(dev);
+
+                       if (!ops->user_pasid_table)
+                               return NULL;
+
+                       /*
+                        * The iommu driver for this device supports user-
+                        * managed PASID table. Therefore page faults for
+                        * any PASID should go through the NESTING domain
+                        * attached to the device RID.
+                        */
+                       attach_handle =3D iommu_attach_handle_get(
+                               dev->iommu_group, IOMMU_NO_PASID,
+                               IOMMU_DOMAIN_NESTED);
+                       if (IS_ERR(attach_handle))
+                               return NULL;
+               }
+       } else {
+               attach_handle =3D iommu_attach_handle_get(dev->iommu_group,
+                                                       IOMMU_NO_PASID, 0);
+               if (IS_ERR(attach_handle))
+                       return NULL;
+       }
+
+       if (!attach_handle->domain->iopf_handler)
+               return NULL;
+       return attach_handle;
+}
+
+static void iopf_error_response(struct device *dev, struct iommu_fault *fa=
ult)
+{
+ const struct iommu_ops *ops =3D dev_iommu_ops(dev);
+ struct iommu_page_response resp =3D {
+ .pasid =3D fault->prm.pasid,
+ .grpid =3D fault->prm.grpid,
+ .code =3D IOMMU_PAGE_RESP_INVALID
+ };
+
+ ops->page_response(dev, NULL, &resp);
+}
+
 /**
  * iommu_report_device_fault() - Report fault event to device driver
  * @dev: the device
@@ -153,16 +204,25 @@ static struct iopf_group
*iopf_group_alloc(struct iommu_fault_param *iopf_param,
  * hardware has been set to block the page faults) and the pending page fa=
ults
  * have been flushed.
  */
-void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
+int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 {
+ struct iommu_attach_handle *attach_handle;
  struct iommu_fault *fault =3D &evt->fault;
  struct iommu_fault_param *iopf_param;
  struct iopf_group abort_group =3D {};
  struct iopf_group *group;

+ attach_handle =3D find_fault_handler(dev, evt);
+ if (!attach_handle)
+ goto err_bad_iopf;
+
+ /*
+ * Something has gone wrong if a fault capable domain is attached but no
+ * iopf_param is setup
+ */
  iopf_param =3D iopf_get_dev_fault_param(dev);
  if (WARN_ON(!iopf_param))
- return;
+ goto err_bad_iopf;

  if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
  report_partial_fault(iopf_param, fault);
@@ -182,38 +242,7 @@ void iommu_report_device_fault(struct device
*dev, struct iopf_fault *evt)
  if (group =3D=3D &abort_group)
  goto err_abort;

- if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
- group->attach_handle =3D iommu_attach_handle_get(dev->iommu_group,
-       fault->prm.pasid,
-       0);
- if (IS_ERR(group->attach_handle)) {
- const struct iommu_ops *ops =3D dev_iommu_ops(dev);
-
- if (!ops->user_pasid_table)
- goto err_abort;
-
- /*
- * The iommu driver for this device supports user-
- * managed PASID table. Therefore page faults for
- * any PASID should go through the NESTING domain
- * attached to the device RID.
- */
- group->attach_handle =3D
- iommu_attach_handle_get(dev->iommu_group,
- IOMMU_NO_PASID,
- IOMMU_DOMAIN_NESTED);
- if (IS_ERR(group->attach_handle))
- goto err_abort;
- }
- } else {
- group->attach_handle =3D
- iommu_attach_handle_get(dev->iommu_group, IOMMU_NO_PASID, 0);
- if (IS_ERR(group->attach_handle))
- goto err_abort;
- }
-
- if (!group->attach_handle->domain->iopf_handler)
- goto err_abort;
+ group->attach_handle =3D attach_handle;

  /*
  * On success iopf_handler must call iopf_group_response() and
@@ -222,7 +251,7 @@ void iommu_report_device_fault(struct device *dev,
struct iopf_fault *evt)
  if (group->attach_handle->domain->iopf_handler(group))
  goto err_abort;

- return;
+ return 0;

 err_abort:
  dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
@@ -232,6 +261,14 @@ void iommu_report_device_fault(struct device
*dev, struct iopf_fault *evt)
  __iopf_free_group(group);
  else
  iopf_free_group(group);
+
+ return 0;
+
+err_bad_iopf:
+ if (fault->type =3D=3D IOMMU_FAULT_PAGE_REQ)
+ iopf_error_response(dev, fault);
+
+ return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(iommu_report_device_fault);

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d87f9cbfc01e..062156a8d87b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1561,7 +1561,7 @@ struct iopf_queue *iopf_queue_alloc(const char *name)=
;
 void iopf_queue_free(struct iopf_queue *queue);
 int iopf_queue_discard_partial(struct iopf_queue *queue);
 void iopf_free_group(struct iopf_group *group);
-void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)=
;
+int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
 void iopf_group_response(struct iopf_group *group,
  enum iommu_page_response_code status);
 #else
@@ -1599,9 +1599,10 @@ static inline void iopf_free_group(struct
iopf_group *group)
 {
 }

-static inline void
+static inline int
 iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 {
+ return -ENODEV;
 }

 static inline void iopf_group_response(struct iopf_group *group,
