From: Stepan Moskovchenko <stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: OMAP and MSM IOMMU driver misbehavior
Date: Tue, 24 Jan 2012 11:14:27 -0800
Message-ID: <4F1F0313.7040008@codeaurora.org>
References: <20120123140355.GA19255@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120123140355.GA19255-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 1/23/2012 6:03 AM, Joerg Roedel wrote:
> Hi,
>
> while reviewing another IOMMU driver again I came across a problem in
> the IOMMU drivers for OMAP and MSM platforms. In both drivers the
> 'domain_destroy with devices attached' case isn't handled correctly.
>
> OMAP driver seems not to track the devices attached to a domain at all.
> So when a domain is destroyed it can happen that the hardware still
> references old (and already freed) page-table pointers.
>
> MSM tracks devices in a domain, but does not automatically remove the
> devices from a domain that is about to be destroyed.
>
> Please tell me when I mis-read the code, otherwise please fix this in
> your drivers so that we can get consistent behavior for IOMMU-API
> users :-)
>
> Thanks,
>
> 	Joerg

Hello

I believe your analysis is correct, and it is a legitimate problem. The 
driver does keep a list of devices attached to a domain, so it should 
not be too hard to detach them. However, I have been quite occupied with 
other things lately, but I can try to get to it when I have some free 
time. Calling detach_dev on each element is what needs to happen in 
theory, but I feel like the main detach_dev code will need to be broken 
out to handle the locking properly. Still, it does not sound 
particularly difficult.

Steve
