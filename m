From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: question about broadcast invalidation and atc invalidation
Date: Fri, 21 Dec 2018 11:53:07 +0000
Message-ID: <fb76a20b-0ff4-d64e-4f9c-c160254b07ce@arm.com>
References: <e33aad8d-ab12-e1c7-0b8b-85fe09260270@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <e33aad8d-ab12-e1c7-0b8b-85fe09260270-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
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
To: Zhongmiao <zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "Chengchuanning (Hisi-Turing)" <chengchuanning-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 21/12/2018 09:31, Zhongmiao wrote:
> Hi Jean:
> 	Now Soft need to make sure build atc inv cmd to smmu after Execute 
> "TLBI" (dvm sync). I don't think it's very reasonable. Why  Smmu The 
> smmu automatically sends the inv atc command when smmu receive 
> broadcast invalidation ?

I'd also like to see this done by hardware, but it's not
straightforward. I see two difficulties with turning broadcast TLBI into
ATC invalidation:

* TLBI uses VMID and ASID to target the TLB entries to invalidate, but
ATS uses RID and PASID. The SMMU would need to do a reverse lookup to
convert VMID:ASID into RID:PASID, and there may be multiple RID:PASID
pairs associated to one VMID:ASID.

* ATS flow control. Each endpoint has a limited number of in-flight ATC
invalidate requests. If the CPU is sending TLBI too fast, the SMMU would
have to buffer them or back-pressure the interconnect, while waiting for
in-flight ATC invalidate to complete.

So for the moment the architecture doesn't support this. We use MMU
notifiers to convert VMID:ASID into RID:PASID and wait for ATC
invalidation to complete.

Thanks,
Jean
