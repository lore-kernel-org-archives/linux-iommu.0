From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 1/1] iommu: Bind process address spaces to devices
Date: Fri, 12 Apr 2019 13:23:51 +0100
Message-ID: <aa213d61-2351-73f4-629c-08a18320fbec@arm.com>
References: <20190410151516.47754-1-jean-philippe.brucker@arm.com>
	<20190410151516.47754-2-jean-philippe.brucker@arm.com>
	<20190411152803.GB29810@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190411152803.GB29810-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "zhangfei.gao-H32Fclmsjq1BDgjK7y7TUQ@public.gmane.org" <zhangfei.gao-H32Fclmsjq1BDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/04/2019 16:28, Joerg Roedel wrote:
> On Wed, Apr 10, 2019 at 04:15:16PM +0100, Jean-Philippe Brucker wrote:
>>=A0 drivers/iommu/iommu.c | 104 ++++++++++++++++++++++++++++++++++++++++++
>>=A0 include/linux/iommu.h |=A0 70 ++++++++++++++++++++++++++++
>>=A0 2 files changed, 174 insertions(+)
> =

> Applied to the api-features branch for now, thanks Jean-Philippe!
> =

> 'for now' because I have a question below.
> =

>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index ed6738c358ca..87fe1cddd817 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -51,10 +51,13 @@ struct device;
>>=A0 struct iommu_domain;
>>=A0 struct notifier_block;
>>=A0 struct iommu_fault_event;
>> +struct iommu_sva;
> =

> The iommu_fault_event doesn't yet exist in my tree, is this patch based
> on something else I need besided Lu Baolus work? I got quite some
> conflicts while applying the patch because of this.

Ugh, sorry about this, I forgot to rebase onto master. The only required
patch is Lu Baolu's "iommu: Add APIs for multiple domains per device".
The iommu_fault_event is introduced by Jacob's fault reporting work, but
is independent from this patch.

There also is a small conflict with the SMMUv3 ATS work, which I'm
hoping to get in v5.2 as well (but will probably require more work).
I'll send next version of ATS applied on top of this patch.

I pushed a cleaner version to git://linux-arm.org/linux-jpb.git sva/api
(with the below mistake fixed as well) and can resend if necessary.

Thanks,
Jean

> =

>> + * @sva_set_ops: Set ops for a SVA handle
> =

> I also removed this line.
> =

> Regards,
> =

> =A0=A0=A0=A0=A0=A0=A0 Joerg
