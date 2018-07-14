From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 9/9] iommu/vt-d: Remove the obsolete per iommu pasid
	tables
Date: Sat, 14 Jul 2018 15:23:32 +0800
Message-ID: <5B49A4F4.4060204@linux.intel.com>
References: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
	<1531113778-28238-10-git-send-email-baolu.lu@linux.intel.com>
	<20180711024506.GB2359@xz-mi> <5B4801A6.1090200@linux.intel.com>
	<20180713050003.GA2379@xz-mi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180713050003.GA2379@xz-mi>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Peter Xu <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 07/13/2018 01:00 PM, Peter Xu wrote:
> On Fri, Jul 13, 2018 at 09:34:30AM +0800, Lu Baolu wrote:
>> Hi Peter,
>>
>> Do you have further comments for this series? I will work out a
>> new version if there are no ones.
> Not for now.  Though since you mentioned about the work to remove the
> pasid state table, not sure whether it'll be nice to put that into
> this series, or even put more patches that are directly related
> (e.g. including the two-level pasid table work and anything related)
> so the series could be more complete.
>
>> Thank you for reviewing my patches. Do you allow me to add your
>> reviewed-by to the patches which you've reviewed?
> I'm glad to read your work.  I didn't leave r-bs because I'm not that
> familiar with the codes so I'm not confident to leave any, just to
> raise the questions.  Please feel free to post a new version as you
> wish, I'll try to leave r-b there if possible.
>
> Thanks,
>

Okay! Thank you!

Best regards,
Lu Baolu
