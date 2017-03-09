From: "sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH 5/9] iommu: add qcom_iommu
Date: Thu, 9 Mar 2017 15:44:23 +0530
Message-ID: <23a001d298bd$f09197c0$d1b4c740$@codeaurora.org>
References: <20170301174258.14618-1-robdclark@gmail.com>
	<20170301174258.14618-6-robdclark@gmail.com>
	<e82dbbc8-c81f-13ea-6ffc-d67204afb748@arm.com>
	<CAF6AEGuH_PZsVCBKeh_=Ev39UZcdgN1Xpn5ekPbC9yr1z_ONQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAF6AEGuH_PZsVCBKeh_=Ev39UZcdgN1Xpn5ekPbC9yr1z_ONQA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Rob Clark' <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Robin Murphy' <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: 'Mark Rutland' <mark.rutland-5wv7dgnIgG8@public.gmane.org>, 'linux-arm-msm' <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, 'Will Deacon' <will.deacon-5wv7dgnIgG8@public.gmane.org>, 'Stanimir Varbanov' <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

>On Tue, Mar 7, 2017 at 12:48 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>wrote:
>> On 01/03/17 17:42, Rob Clark wrote:
>>> An iommu driver for Qualcomm "B" family devices which do not
>>> completely implement the ARM SMMU spec.
>>
>> Is that actually true, or is it just that it's a compliant SMMU on
>> which firmware has set SCR1.GASRAE? (which makes the global address
>> space secure-access-only). I don't know which Qualcomm SoCs are the
>> ones apparently using a plain ARM MMU-500 IP, but if any of those are
>> also running this particular firmware configuration that puts us in a
>> somewhat weird situation with respect to drivers :/
>>
>
>I can't say for sure, I don't really know exactly what tz is doing.
>Although the net effect from linux kernel perspective is that it isn't really
>"compliant".  And I think the SMMU_INTR_SEL_NS part (for controlling routing
>of cb irqs) is non-standard.
>
>As far as I can tell, if there was firmware that allowed access to the global
>address space, I don't think it ever escaped outside of qcom's labs (ie. might
>have existed on early versions of chips for new SoC bring-up.. but I think from
>upstream perspective we can ignore that).

Right, I would think this is the only one which has the MMU-500 behind the
*secure* access constraints to global registers. The next set of Socs which
were integrating the MMU-500 had this addressed in different ways, means
its going to work with the upstream arm-smmu driver itself.

Regards,
 Sricharan
