From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: IO_PAGE_FAULTs on unity mapped regions during amd_iommu_init()
	in Linux 3.4
Date: Mon, 11 Feb 2013 23:18:25 +0100
Message-ID: <20130211221825.GB25591@8bytes.org>
References: <1359657210.6061.3.camel@lorien2>
	<20130201130035.GE25591@8bytes.org>
	<1359743519.2759.38.camel@lorien2>
	<20130205133104.GC2532@8bytes.org>
	<CAKocOOO6Z2LyLYiuQMWf4iv4PAP8h5jbNWxRcSXKgXD1es6GYg@mail.gmail.com>
	<20130206121223.GT25591@8bytes.org>
	<1360204850.2615.10.camel@lorien2>
	<20130211194901.GA18115@kroah.com>
	<1360616223.2950.15.camel@lorien2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1360616223.2950.15.camel@lorien2>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 11, 2013 at 01:57:03PM -0700, Shuah Khan wrote:
> I was hoping Joerg's patch would make it into Linus's tree by now. I
> tested the original patch and did the back-port to 3.4 and 3.0 at the
> same time, before I loose the test system.

I will send the patch with the next merge window. It already has the
stable-tag and should be noticed when it hits Linus' tree. Since Shuah's
system is the only one I know of which actually implements IVMD entries
in the IVRS table the problem seemed not to be important enough to send
another pull-request for v3.8.

Regards,

	Joerg
