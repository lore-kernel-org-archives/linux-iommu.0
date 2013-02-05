From: Shuah Khan <shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: IO_PAGE_FAULTs on unity mapped regions during amd_iommu_init() in
	Linux 3.4
Date: Tue, 5 Feb 2013 06:57:21 -0700
Message-ID: <CAKocOOO6Z2LyLYiuQMWf4iv4PAP8h5jbNWxRcSXKgXD1es6GYg@mail.gmail.com>
References: <1359657210.6061.3.camel@lorien2>
	<20130201130035.GE25591@8bytes.org>
	<1359743519.2759.38.camel@lorien2>
	<20130205133104.GC2532@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130205133104.GC2532-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 5, 2013 at 6:31 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> Hi Shuah,
>
> On Fri, Feb 01, 2013 at 11:31:59AM -0700, Shuah Khan wrote:
>> Yes, 3.7 has the same window of opportunity for this race condition,
>> however I couldn't figure out why it doesn't happen on 3.7. On 3.7 the
>> window between amd_iommu_init_hardware() and amd_iommu_init_dma_ops()
>> might actually be wider than the window in 3.4.
>
> I think this is highly timing related. IOMMU initialization may have
> been moved by a few milliseconds between the kernel versions which might
> cause the warnings to appear or disappear. I don't think it has much
> value to dive deeper into the differences between the initialization
> sequences.
>
> As somethimes with such issues there is a simple and a more complex fix
> for that. I'll try to come up with a simple fix for the next merge
> window and implement the clean and more complex one for the next one.
>

Hi Joerg,

Thanks much. I will hang on to this test system for testing your fix.

-- Shuah
