From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: fix the left value check of cmd buffer
Date: Wed, 4 Jan 2017 15:24:13 +0100
Message-ID: <20170104142413.GC16521@suse.de>
References: <1481545706-1610-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1481545706-1610-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 12, 2016 at 07:28:26AM -0500, Huang Rui wrote:
> The generic command buffer entry is 128 bits (16 bytes), so the offset
> of tail and head pointer should be 16 bytes aligned and increased with
> 0x10 per command.
> 
> When cmd buf is full, head = (tail + 0x10) % CMD_BUFFER_SIZE.
> 
> So when left space of cmd buf should be able to store only two
> command, we should be issued one COMPLETE_WAIT additionally to wait
> all older commands completed. Then the left space should be increased
> after IOMMU fetching from cmd buf.
> 
> So left check value should be left <= 0x20 (two commands).
> 
> Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

Applied to the fixes branch, thanks.
