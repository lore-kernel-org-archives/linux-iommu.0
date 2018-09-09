From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: No video output on 4.19-rc1 on Dell XPS 13 9360
Date: Sun, 9 Sep 2018 10:01:17 +0800
Message-ID: <89dff474-7baa-83ce-d70d-fffc4699d3ce@linux.intel.com>
References: <20180908165747.16c2843c@fire.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180908165747.16c2843c-STI+9kRLTpF82hYKe6nXyg@public.gmane.org>
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
To: Dmitrii Tcvetkov <demfloro-dmrBKrQMA3sox3rIn2DAYQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

The fix has been posted here.

https://lkml.org/lkml/2018/9/8/14

Best regards,
Lu Baolu

On 09/08/2018 09:57 PM, Dmitrii Tcvetkov wrote:
> I've sent the email[1] before to iommu and lkml mailing lists only, but
> according to iommu mailing list archive it wasn't received[2]. I'm
> resending it to Lu Baolu and Joerg Roedel with proper kernel .config
> file. Sorry if the duplication is unnecessary.
> 
> Since 4.19-rc1 my laptop boots with vertical static set of rows of dots
> on the screen instead of proper video output. SSH'ing into it allowed
> to get dmesg-without-pt.log output, PCI device 00:02.0 is VGA
> compatible controller: Intel Corporation HD Graphics 620 (rev 02)
> 
> Appending "iommu=pt" to kernel cmdline allowed to boot with functional
> graphics, but gave dmesg-with-pt.log output.
> 
> Bisect between v4.18 and v4.19-rc1 tags led me to commit
> a7fc93fed94b173e2 (iommu/vt-d: Allocate and free pasid table).
> 
> Reverting this commit allows to build kernel on current master
> (a12ed06ba2d3fa60e), which boots with functional graphical output
> without specifying "iommu=pt".
> Dmesg output is in dmesg-with-revert.log.
> 
> Without the revert current master boots like 4.19-rc1.
> 
> [1] https://lkml.org/lkml/2018/9/7/1081
> [2] https://lists.linuxfoundation.org/pipermail/iommu/2018-September/date.html
> 
